import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class VerifyOtpUsecase {
  final AuthRepository repository;

  VerifyOtpUsecase(this.repository);

  Future<Either<Failure, UserEntity>> execute(String otp, String email) async {
    final response = await repository.verifyOTP(otp, email);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
