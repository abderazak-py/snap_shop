import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signInWithEmail(String email, String password);

  Future<UserEntity?> signUpWithEmail(String email, String password);

  Future<UserEntity> verifyOTP(String otp, String email);

  Future<UserEntity?> signInWithGoogleNative({required String webClientId});

  Future<UserEntity?> getCurrentUser();

  Future<bool> isUserSignedIn();

  Future<void> signOut();
}
