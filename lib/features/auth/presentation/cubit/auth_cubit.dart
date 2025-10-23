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
      (user) => emit(AuthSuccess(user: user)),
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

  /// Sign out
  Future<void> signOut() async {
    final response = await signOutUseCase.execute();
    response.fold(
      (f) => emit(AuthFailure(error: f.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
