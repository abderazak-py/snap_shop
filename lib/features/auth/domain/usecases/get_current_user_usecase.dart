import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute() async {
    final response = await repository.getCurrentUser();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
