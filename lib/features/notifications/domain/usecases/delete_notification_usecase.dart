import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/notification_repo.dart';

class DeleteNotificationUsecase {
  final NotificationsRepository repository;
  DeleteNotificationUsecase(this.repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await repository.deleteNotification(id);
  }
}
