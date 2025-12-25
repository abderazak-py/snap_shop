import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/settings_repo.dart';

class ChangeNameUsecase {
  final SettingsRepository repository;

  ChangeNameUsecase(this.repository);

  Future<Either<Failure, void>> execute(String name) async {
    return await repository.changeName(name);
  }
}
