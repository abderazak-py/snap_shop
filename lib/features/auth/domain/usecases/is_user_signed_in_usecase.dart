import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/auth_repo.dart';

class IsUserSignedInUsecase {
  final AuthRepository repository;

  IsUserSignedInUsecase(this.repository);

  Future<Either<Failure, bool>> execute() async {
    final response = await repository.isUserSignedIn();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
