import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';

class ChangePasswordUsecase {
  final SettingsRepository repository;

  ChangePasswordUsecase(this.repository);

  Future<Either<Failure, void>> execute(String password) async {
    return await repository.changePassword(password);
  }
}
