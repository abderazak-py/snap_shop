import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(
    String email,
    String password,
  ) async {
    final response = await repository.signUpWithEmail(email, password);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
