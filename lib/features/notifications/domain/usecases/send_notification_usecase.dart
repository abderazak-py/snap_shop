import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/notification_repo.dart';

class SendNotificationUsecase {
  final NotificationsRepository repository;
  SendNotificationUsecase(this.repository);

  Future<Either<Failure, void>> execute(String title, String body) async {
    return await repository.sendNotification(title, body);
  }
}
