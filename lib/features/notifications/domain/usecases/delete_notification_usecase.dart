import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/notifications/domain/repos/notification_repo.dart';

class DeleteNotificationUsecase {
  final NotificationsRepository repository;
  DeleteNotificationUsecase(this.repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await repository.deleteNotification(id);
  }
}
