import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

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
