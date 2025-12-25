import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

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
