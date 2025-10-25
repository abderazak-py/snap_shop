import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';

class ChangeAvatarUsecase {
  final SettingsRepository repository;

  ChangeAvatarUsecase(this.repository);

  Future<Either<Failure, void>> execute(File avatar) async {
    return await repository.changeAvatar(avatar);
  }
}
