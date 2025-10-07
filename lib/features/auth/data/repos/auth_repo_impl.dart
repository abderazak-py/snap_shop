import 'package:gotrue/src/types/types.dart';
import 'package:snap_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    final userModel = await remoteDataSource.signInWithEmail(email, password);
    if (userModel == null) return null;
    return UserEntity(id: userModel.id, email: userModel.email);
  }

  @override
  Future<UserEntity?> signUpWithEmail(String email, String password) async {
    final userModel = await remoteDataSource.signUpWithEmail(email, password);
    if (userModel == null) return null;
    return UserEntity(id: userModel.id, email: userModel.email);
  }

  @override
  Future<UserEntity?> signInWithGoogleNative({
    required String webClientId,
    String? iosClientId,
  }) async {
    final user = await remoteDataSource.signInWithGoogleNative(
      webClientId: webClientId,
    );
    if (user == null) return null;
    return _mapUserToEntity(user);
  }

  UserEntity _mapUserToEntity(User user) {
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
    );
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await remoteDataSource.getCurrentUser();
    if (user == null) return null;
    return UserEntity(id: user.id, email: user.email);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
