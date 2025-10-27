import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final ISupabaseService supabaseService;

  AuthRemoteDataSource(this.supabaseService);

  //==============|| Sign up with email and password ||====
  Future<Either<Failure, UserModel>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseService.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return Right(UserModel.fromMap(response.user!.toJson()));
      } else {
        return Left(Failure('Invalid email or password'));
      }
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| Sign up with email and password ||====
  Future<Either<Failure, UserModel>> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseService.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return Right(UserModel.fromMap(response.user!.toJson()));
      } else {
        return Left(Failure('Invalid email or password'));
      }
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| Sign up with google ||================
  Future<Either<Failure, UserModel>> signInWithGoogleNative({
    required String webClientId,
  }) async {
    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: webClientId);
    final googleUser = await googleSignIn.authenticate();

    /// Authorization is required to obtain the access token with the appropriate scopes for Supabase authentication,
    /// while also granting permission to access user information.
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      return Left(Failure('No ID Token found.'));
    }
    await supabaseService.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );
    final res = await supabaseService.auth.getUser();
    final user = res.user;
    if (user == null) {
      return Left(Failure('No user found.'));
    }
    final userName = user.userMetadata?['name'] ?? '';
    final avatarUrl = user.userMetadata?['avatar_url'] as String? ?? '';
    await supabaseService.client.from('profiles').upsert({
      'id': user.id,
      'full_name': userName,
      'avatar': avatarUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
    return Right(UserModel.fromMap(user.toJson()));
  }

  //==============|| Get current user ||===================
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final session = supabaseService.auth.currentSession;
      final user = session?.user;
      if (user == null) {
        return Left(Failure('please login first'));
      }

      final profile = await supabaseService.client
          .from('profiles')
          .select('full_name, avatar, user_role')
          .eq('id', user.id)
          .single();

      final userJson = user.toJson();
      final merged = {
        ...userJson,
        'name': profile['full_name'] ?? '',
        'avatar': profile['avatar'] ?? '',
        'role': profile['user_role'] ?? 'customer',
      };

      final userModel = UserModel.fromMap(merged);
      return Right(userModel);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.message));
    } on AuthApiException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| is user signed in ||==================
  Future<Either<Failure, bool>> isUserSignedIn() async {
    try {
      final session = supabaseService.auth.currentSession;
      return Right(session != null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| verify with otp ||====================
  Future<Either<Failure, UserModel>> verifyOTP(String otp, String email) async {
    try {
      final response = await supabaseService.auth.verifyOTP(
        type: OtpType.signup,
        token: otp, //====|| Sign up with email and password ||====
        email: email,
      );
      if (response.session == null || response.user == null) {
        throw Exception('Please login first');
      } else {
        return Right(UserModel.fromMap(response.user!.toJson()));
      }
      //add this line if there is an error
      //return supabaseService.auth.currentUser!;
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| resend otp ||=========================
  Future<Either<Failure, void>> resendOTP(String email) async {
    try {
      if (supabaseService.auth.currentUser?.emailConfirmedAt != null) {
        return const Right(null);
      }
      await supabaseService.auth.resend(type: OtpType.signup, email: email);
      return Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //==============|| Sign out user ||======================
  Future<Either<Failure, void>> signOut() async {
    try {
      await supabaseService.auth.signOut();
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure(e.toString()));
    } on AuthApiException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
