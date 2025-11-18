import { createClient } from 'npm:@supabase/supabase-js@2';
import { JWT } from 'npm:google-auth-library@9';
const supabase = createClient(Deno.env.get('SUPABASE_URL'), Deno.env.get('SUPABASE_SERVICE_ROLE_KEY'));
Deno.serve(async (req)=>{
  const payload = await req.json();
  const { data } = await supabase.from('profiles').select('fcm_token').eq('id', payload.record.user_id).single();
  const fcmToken = data.fcm_token;
  const raw = Deno.env.get('private_key') ?? '';
  const key = raw.includes('\\n') ? raw.replace(/\\n/g, '\n') : raw;
  const accessToken = await getAccessToken({
    clientEmail: Deno.env.get('client_email'),
    privateKey: key
  });
  const res = await fetch(`https://fcm.googleapis.com/v1/projects/${Deno.env.get('project_id')}/messages:send`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${accessToken}`
    },
    body: JSON.stringify({
      message: {
        token: fcmToken,
        notification: {
          title: payload.record.title ?? 'Notification',
          body: payload.record.body ?? ''
        }
      }
    })
  });
  const resData = await res.json();
  if (res.status < 200 || 299 < res.status) {
    throw resData;
  }
  return new Response(JSON.stringify(resData), {
    headers: {
      'Content-Type': 'application/json'
    }
  });
});
const getAccessToken = ({ clientEmail, privateKey })=>{
  return new Promise((resolve, reject)=>{
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: [
        'https://www.googleapis.com/auth/firebase.messaging'
      ]
    });
    jwtClient.authorize((err, tokens)=>{
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens.access_token);
    });
  });
};
