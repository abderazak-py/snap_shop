import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/settings_repo.dart';

class ChangeEmailUsecase {
  final SettingsRepository repository;

  ChangeEmailUsecase(this.repository);

  Future<Either<Failure, void>> execute(String email) async {
    return await repository.changeEmail(email);
  }
}
