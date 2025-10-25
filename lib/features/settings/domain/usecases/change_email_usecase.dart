import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';

class ChangeEmailUsecase {
  final SettingsRepository repository;

  ChangeEmailUsecase(this.repository);

  Future<Either<Failure, void>> execute(String email) async {
    return await repository.changeEmail(email);
  }
}
