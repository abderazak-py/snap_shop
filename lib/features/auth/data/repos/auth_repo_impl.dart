import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
    String email,
    String password,
  ) async {
    final response = await remoteDataSource.signInWithEmail(email, password);
    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(_mapUserToEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail(
    String email,
    String password,
  ) async {
    final response = await remoteDataSource.signUpWithEmail(email, password);
    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(_mapUserToEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogleNative({
    required String webClientId,
    String? iosClientId,
  }) async {
    final response = await remoteDataSource.signInWithGoogleNative(
      webClientId: webClientId,
    );
    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(_mapUserToEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    final response = await remoteDataSource.getCurrentUser();
    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(_mapUserToEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, bool>> isUserSignedIn() async {
    final response = await remoteDataSource.isUserSignedIn();
    return response.fold(
      (failure) => Left(failure),
      (isSignedIn) => Right(isSignedIn),
    );
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    final response = await remoteDataSource.signOut();
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOTP(
    String otp,
    String email,
  ) async {
    final response = await remoteDataSource.verifyOTP(otp, email);
    return response.fold(
      (failure) => Left(failure),
      (userModel) => Right(_mapUserToEntity(userModel)),
    );
  }

  @override
  Future<Either<Failure, void>> resendOTP(String email) async {
    final response = await remoteDataSource.resendOTP(email);
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  UserEntity _mapUserToEntity(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String? ?? '',
      avatarUrl: user.userMetadata?['avatar_url'] as String? ?? '',
    );
  }
}
