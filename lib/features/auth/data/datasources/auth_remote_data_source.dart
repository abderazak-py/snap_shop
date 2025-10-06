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

  /// Sign out user
  Future<void> signOut() async {
    try {
      await supabaseService.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }
}
