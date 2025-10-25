import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDatasource remoteDataSource;
  SettingsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> changeEmail(String email) async {
    return await remoteDataSource.changeEmail(email);
  }

  @override
  Future<Either<Failure, void>> changePassword(String password) async {
    return await remoteDataSource.changePassword(password);
  }

  @override
  Future<Either<Failure, void>> changeName(String name) async {
    return await remoteDataSource.changeName(name);
  }

  @override
  Future<Either<Failure, void>> changeAvatar(File imageFile) async {
    return await remoteDataSource.changeAvatar(imageFile);
  }
}
