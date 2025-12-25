import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/auth_repo.dart';

class ResendOtpUsecase {
  final AuthRepository repository;

  ResendOtpUsecase(this.repository);

  Future<Either<Failure, void>> execute(String email) async {
    final response = await repository.resendOTP(email);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
