import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

class IsUserSignedInUsecase {
  final AuthRepository repository;

  IsUserSignedInUsecase(this.repository);

  Future<bool> execute() async {
    return await repository.isUserSignedIn();
  }
}
