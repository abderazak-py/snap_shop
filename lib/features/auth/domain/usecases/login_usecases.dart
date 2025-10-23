import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute(
    String email,
    String password,
  ) async {
    final response = await repository.signInWithEmail(email, password);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
