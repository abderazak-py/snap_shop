import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/settings_repo.dart';

class ChangeAvatarUsecase {
  final SettingsRepository repository;

  ChangeAvatarUsecase(this.repository);

  Future<Either<Failure, void>> execute(File avatar) async {
    return await repository.changeAvatar(avatar);
  }
}
