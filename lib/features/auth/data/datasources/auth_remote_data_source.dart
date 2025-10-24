import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final ISupabaseService supabaseService;

  AuthRemoteDataSource(this.supabaseService);

  //==============|| Sign up with email and password ||====
  Future<Either<Failure, User>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseService.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return Right(response.user!);
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
  Future<Either<Failure, User>> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseService.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return Right(response.user!);
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
  Future<Either<Failure, User>> signInWithGoogleNative({
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

    //this to update user metadata with google so the user doesnt need to enter them manually
    await supabaseService.auth.updateUser(
      UserAttributes(
        data: {
          'name': userName.split(' ').first,
          'avatar_url': user.userMetadata?['avatar_url'] ?? '',
        },
      ),
    );
    final response = await supabaseService.auth.getUser();
    final updatedUser = response.user;
    if (updatedUser == null) {
      return Left(Failure('Fialed to get name and picture'));
    } else {
      return Right(updatedUser);
    }
  }

  //==============|| Get current user ||===================
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final response = supabaseService.auth.currentSession;
      if (response?.user != null) {
        return Right(response!.user);
      } else {
        return Left(Failure('please login first'));
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
  Future<Either<Failure, User>> verifyOTP(String otp, String email) async {
    try {
      final response = await supabaseService.auth.verifyOTP(
        type: OtpType.signup,
        token: otp, //====|| Sign up with email and password ||====
        email: email,
      );
      if (response.session == null || response.user == null) {
        throw Exception('Please login first');
      } else {
        return Right(response.user!);
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
