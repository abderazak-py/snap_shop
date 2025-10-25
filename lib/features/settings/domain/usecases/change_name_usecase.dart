import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';

class ChangeNameUsecase {
  final SettingsRepository repository;

  ChangeNameUsecase(this.repository);

  Future<Either<Failure, void>> execute(String name) async {
    return await repository.changeName(name);
  }
}
