import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/notification_entity.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
  Future<Either<Failure, void>> deleteNotification(int id);
  Future<Either<Failure, void>> sendNotification(String title, String body);
}
