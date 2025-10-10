import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() async {
    await repository.signOut();
  }
}
