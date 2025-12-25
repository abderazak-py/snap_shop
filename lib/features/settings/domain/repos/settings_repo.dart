import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> changeName(String name);
  Future<Either<Failure, void>> changePassword(String password);
  Future<Either<Failure, void>> changeEmail(String email);
  Future<Either<Failure, void>> changeAvatar(File imageFile);
}
