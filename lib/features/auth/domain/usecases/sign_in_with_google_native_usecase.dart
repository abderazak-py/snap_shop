import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class SignInWithGoogleNativeUseCase {
  final AuthRepository repository;

  SignInWithGoogleNativeUseCase(this.repository);

  Future<UserEntity?> execute({
    required String webClientId,
    String? iosClientId,
  }) async {
    return await repository.signInWithGoogleNative(webClientId: webClientId);
  }
}
