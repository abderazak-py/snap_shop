import 'package:equatable/equatable.dart';
// ignore: prefer_relative_imports
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final String role;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      avatar: map['avatar'] as String?,
      role: map['role'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'role': role,
    };
  }

  UserEntity toEntity() => UserEntity(
    id: id,
    email: email,
    name: name,
    avatarUrl: avatar,
    role: role,
  );

  @override
  List<Object?> get props => [id, email, name, avatar, role];
}
