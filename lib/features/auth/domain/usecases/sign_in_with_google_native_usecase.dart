import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class SignInWithGoogleNativeUseCase {
  final AuthRepository repository;

  SignInWithGoogleNativeUseCase(this.repository);

  Future<Either<Failure, UserEntity>> execute({
    required String webClientId,
    String? iosClientId,
  }) async {
    final response = await repository.signInWithGoogleNative(
      webClientId: webClientId,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
