import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/auth_repo.dart';
import '../entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute() async {
    final response = await repository.getCurrentUser();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
