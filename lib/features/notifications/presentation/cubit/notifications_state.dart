part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {
  final List<NotificationEntity> notifications;
  const NotificationsSuccess(this.notifications);
}

final class NotificationsFailure extends NotificationsState {
  final String message;
  const NotificationsFailure(this.message);
}
