class NotificationEntity {
  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String userId;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
