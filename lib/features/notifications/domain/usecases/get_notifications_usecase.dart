import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/notifications/domain/entities/notification_entity.dart';
import 'package:snap_shop/features/notifications/domain/repos/notification_repo.dart';

class GetNotificationsUsecase {
  final NotificationsRepository repository;
  GetNotificationsUsecase(this.repository);

  Future<Either<Failure, List<NotificationEntity>>> execute() async {
    return await repository.getNotifications();
  }
}
