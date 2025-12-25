import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/notification_entity.dart';
import '../repos/notification_repo.dart';

class GetNotificationsUsecase {
  final NotificationsRepository repository;
  GetNotificationsUsecase(this.repository);

  Future<Either<Failure, List<NotificationEntity>>> execute() async {
    return await repository.getNotifications();
  }
}
