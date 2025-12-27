import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecases.dart';
import '../../domain/usecases/register_usecases.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/sign_in_with_google_native_usecase.dart';
import '../../domain/usecases/sign_in_with_otp.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SignInWithGoogleNativeUseCase signInWithGoogleNativeUseCase;
  final SignOutUseCase signOutUseCase;
  final VerifyOtpUsecase verifyOtpUseCase;
  final ResendOtpUsecase resendOtpUsecase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignInWithOtp signInWithOtpUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.signInWithGoogleNativeUseCase,
    required this.signOutUseCase,
    required this.verifyOtpUseCase,
    required this.resendOtpUsecase,
    required this.getCurrentUserUseCase,
    required this.signInWithOtpUseCase,
  }) : super(AuthInitial());

  /// Login with email and password
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final response = await loginUseCase.execute(email, password);
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  /// Register with email and password
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    final response = await registerUseCase.execute(email, password);
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  /// Sign in with Google (native)
  Future<void> signInWithGoogle({required String webClientId}) async {
    emit(AuthLoading());
    final response = await signInWithGoogleNativeUseCase.execute(
      webClientId: webClientId,
    );
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (user) => emit(AuthSuccessConfirmed(user: user)),
    );
  }

  /// Sign in with Google (native)
  Future<void> signInWithOtp({required String email}) async {
    emit(AuthLoading());
    final response = await signInWithOtpUseCase.execute(email);
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (_) => emit(AuthOtpSuccess()),
    );
  }

  Future<void> getUser() async {
    emit(AuthLoading());
    final response = await getCurrentUserUseCase.execute();
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (user) => emit(AuthSuccessConfirmed(user: user)),
    );
  }

  Future<void> verifyOtp({required String otp, required String email}) async {
    emit(AuthLoading());
    final response = await verifyOtpUseCase.execute(otp, email);
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> resendOTP({required String email}) async {
    final response = await resendOtpUsecase.execute(email);
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (_) => startOtpTimer(),
    );
  }

  Timer? _otpTimer;
  void startOtpTimer() {
    _otpTimer?.cancel();

    int seconds = 60;
    emit(OtpTimerChanged(secondsRemaining: seconds, showSendButton: false));

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds -= 1;

      if (seconds <= 0) {
        emit(OtpTimerChanged(secondsRemaining: 0, showSendButton: true));
        timer.cancel();
        _otpTimer = null;
        return;
      }

      emit(OtpTimerChanged(secondsRemaining: seconds, showSendButton: false));
    });
  }

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }

  /// Sign out
  Future<void> signOut() async {
    final response = await signOutUseCase.execute();
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
