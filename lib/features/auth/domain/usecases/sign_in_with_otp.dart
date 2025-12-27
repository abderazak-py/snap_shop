import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/auth_repo.dart';

class SignInWithOtp {
  final AuthRepository repository;

  SignInWithOtp(this.repository);

  Future<Either<Failure, void>> execute(String email) async {
    final response = await repository.signInWithOtp(email);
    return response.fold((l) => Left(l), (_) => Right(null));
  }
}
