import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

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
