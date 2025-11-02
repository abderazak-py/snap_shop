import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:snap_shop/features/notifications/domain/entities/notification_entity.dart';
import 'package:snap_shop/features/notifications/domain/repos/notification_repo.dart';

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
}
