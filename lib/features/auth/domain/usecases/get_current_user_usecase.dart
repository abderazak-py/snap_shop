import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserEntity?> execute() async {
    return await repository.getCurrentUser();
  }
}
