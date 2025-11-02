import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends Equatable {
  final int id;
  final DateTime createdAt;
  final String title;
  final String body;
  final String userId;

  const NotificationModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      title: map['title'] as String,
      body: map['body'] as String,
      userId: map['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'body': body,
      'user_id': userId,
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      createdAt: entity.createdAt,
      title: entity.title,
      body: entity.body,
      userId: entity.userId,
    );
  }
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      userId: userId,
    );
  }

  @override
  List<Object?> get props => [id, title, body, createdAt, userId];
}
