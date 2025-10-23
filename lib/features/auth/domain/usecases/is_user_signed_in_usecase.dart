import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class IsUserSignedInUsecase {
  final AuthRepository repository;

  IsUserSignedInUsecase(this.repository);

  Future<Either<Failure, bool>> execute() async {
    final response = await repository.isUserSignedIn();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
