// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/usecases/login_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/register_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/sign_in_with_google_native_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SignInWithGoogleNativeUseCase signInWithGoogleNativeUseCase;
  final SignOutUseCase signOutUseCase;
  final VerifyOtpUsecase verifyOtpUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.signInWithGoogleNativeUseCase,
    required this.signOutUseCase,
    required this.verifyOtpUseCase,
  }) : super(AuthInitial());

  /// Login with email and password
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(email, password);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(error: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  /// Register with email and password
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.execute(email, password);
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(error: 'Registration failed'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  /// Sign in with Google (native)
  Future<void> signInWithGoogle({
    required String webClientId,
    String? iosClientId,
  }) async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogleNativeUseCase.execute(
        webClientId: webClientId,
      );
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailure(error: 'Google sign-in was cancelled'));
      }
    } catch (e) {
      emit(AuthFailure(error: 'Google sign-in failed: ${e.toString()}'));
    }
  }

  Future<void> verifyOtp({required String otp, required String email}) async {
    try {
      final user = await verifyOtpUseCase.execute(otp, email);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(error: 'Verigy Otp failed: ${e.toString()}'));
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await signOutUseCase.execute();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(error: 'Sign out failed: ${e.toString()}'));
    }
  }
}
