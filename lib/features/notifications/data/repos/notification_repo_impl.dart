import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/notifications_remote_data_source.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repos/notification_repo.dart';

class NotificationRepositoryImpl extends NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final response = await remoteDataSource.getNotifications();
    return response.fold(
      (l) => Left(l),
      (r) => Right(r.map((e) => e.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, void>> deleteNotification(int id) async {
    final response = await remoteDataSource.deleteNotification(id);
    return response.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, void>> sendNotification(
    String title,
    String body,
  ) async {
    final response = await remoteDataSource.sendNotification(title, body);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
