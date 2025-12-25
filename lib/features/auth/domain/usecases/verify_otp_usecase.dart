import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class VerifyOtpUsecase {
  final AuthRepository repository;

  VerifyOtpUsecase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String otp, String email) async {
    final response = await repository.verifyOTP(otp, email);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
