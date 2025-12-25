import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/delete_notification_usecase.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUsecase getNotificationsUsecase;
  final DeleteNotificationUsecase deleteNotificationUsecase;
  NotificationsCubit({
    required this.getNotificationsUsecase,
    required this.deleteNotificationUsecase,
  }) : super(NotificationsInitial());

  void getNotifications() async {
    emit(NotificationsLoading());
    final result = await getNotificationsUsecase.execute();
    result.fold(
      (failure) => emit(NotificationsFailure(failure.message)),
      (notifications) => emit(NotificationsSuccess(notifications)),
    );
  }

  void deleteNotification(int id) async {
    final current = (state is NotificationsSuccess)
        ? List.of((state as NotificationsSuccess).notifications)
        : <NotificationEntity>[];
    emit(NotificationsLoading());
    final result = await deleteNotificationUsecase.execute(id);
    final updated = current.where((e) => e.id != id).toList();
    result.fold(
      (failure) => emit(NotificationsFailure(failure.message)),
      (_) => emit(NotificationsSuccess(updated)),
    );
  }
}
