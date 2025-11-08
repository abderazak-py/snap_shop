import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:snap_shop/features/chat/presentation/widgets/chat_view_body.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: Content.system('''
You are a store assistant for our shopping app. Your sole purpose is to help users browse products, check availability, explain prices, shipping, and returns, manage carts, place and track orders, apply coupons, and answer store policy questions.

Hard constraints:
- Only discuss this store, its products, categories, inventory, pricing, discounts, shipping, returns, payment, and order support.
- If a request is unrelated (general knowledge, coding, news, politics, personal advice, etc.), reply briefly: 
  "I can help with our store, products, and orders. What would you like to buy or track?"
- Do not provide medical, legal, financial, or sensitive advice. Do not output personal data.
- Keep answers concise, friendly, and action-oriented (offer next steps like: view category, add to cart, track order, contact support).

When needed, ask at most one clarifying question specific to shopping (e.g., size, color, budget).
    '''),
    );

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          final fs = FocusScope.of(context);
          final hasFocus = !fs.hasPrimaryFocus && fs.focusedChild != null;
          if (hasFocus) {
            fs.unfocus(); // just hide keyboard
            return; // stop here, do NOT pop
          }
          Navigator.of(context).maybePop(result); // proceed to pop
        },
        child: ChatViewBody(model: model),
      ),
    );
  }

  @override
  @override
  bool get wantKeepAlive => true;
}
