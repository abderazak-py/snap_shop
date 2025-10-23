import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signUpWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> verifyOTP(String otp, String email);

  Future<Either<Failure, UserEntity>> signInWithGoogleNative({
    required String webClientId,
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, bool>> isUserSignedIn();

  Future<Either<Failure, void>> signOut();
}
