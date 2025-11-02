import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/notifications/domain/entities/notification_entity.dart';
import 'package:snap_shop/features/notifications/domain/usecases/get_notifications_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUsecase getNotificationsUsecase;
  NotificationsCubit({required this.getNotificationsUsecase})
    : super(NotificationsInitial());

  void getNotifications() async {
    emit(NotificationsLoading());
    final result = await getNotificationsUsecase.execute();
    result.fold(
      (failure) => emit(NotificationsFailure(failure.message)),
      (notifications) => emit(NotificationsSuccess(notifications)),
    );
  }
}
