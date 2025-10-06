import 'package:snap_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';

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
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }
}
