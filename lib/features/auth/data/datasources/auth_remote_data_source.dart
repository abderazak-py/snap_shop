import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final ISupabaseService supabaseService;

  AuthRemoteDataSource(this.supabaseService);

  /// Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final response = await supabaseService.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  /// Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final response = await supabaseService.auth.signUp(
        email: email,
        password: password,
      );
      return response.user;
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  Future<User?> signInWithGoogleNative({required String webClientId}) async {
    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: webClientId);
    final googleUser = await googleSignIn.attemptLightweightAuthentication();
    // or await googleSignIn.authenticate(); which will return a GoogleSignInAccount or throw an exception
    if (googleUser == null) {
      throw AuthException('Failed to sign in with Google.');
    }

    /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
    /// while also granting permission to access user information.
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }
    await supabaseService.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
    final user = await getCurrentUser();
    return user;
  }

  /// Get current user
  Future<User?> getCurrentUser() async {
    try {
      final session = supabaseService.auth.currentSession;
      return session?.user;
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  // is user signed in
  Future<bool> isUserSignedIn() async {
    final session = supabaseService.auth.currentSession;
    return session != null;
  }

  //verify with otp
  Future<User> verifyOTP(String otp, String email) async {
    try {
      final response = await supabaseService.auth.verifyOTP(
        type: OtpType.signup,
        token: otp,
        email: email,
      );
      if (response.session == null || response.user == null) {
        throw Exception('OTP valid but no session or user created');
      }
      return supabaseService.auth.currentUser!;
    } catch (e) {
      throw Exception('Resend failed: ${e.toString()}');
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      await supabaseService.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }
}
