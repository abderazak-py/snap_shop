import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/features/auth/domain/usecases/login_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/register_usecases.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final user = await LoginUseCase(
      sl<AuthRepository>(),
    ).execute(email, password);
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: 'Login failed'));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    final user = await RegisterUseCase(
      sl<AuthRepository>(),
    ).execute(email, password);
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthFailure(error: 'Registration failed'));
    }
  }
}
