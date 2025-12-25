import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/settings_repo.dart';

class ChangePasswordUsecase {
  final SettingsRepository repository;

  ChangePasswordUsecase(this.repository);

  Future<Either<Failure, void>> execute(String password) async {
    return await repository.changePassword(password);
  }
}
