import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class VerifyOtpUsecase {
  final AuthRepository repository;

  VerifyOtpUsecase(this.repository);

  Future<UserEntity> execute(String otp, String email) async {
    return await repository.verifyOTP(otp, email);
  }
}
