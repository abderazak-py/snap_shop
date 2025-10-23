import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, void>> execute() async {
    final response = await repository.signOut();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
