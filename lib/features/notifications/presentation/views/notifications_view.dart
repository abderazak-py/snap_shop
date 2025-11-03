import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/core/widgets/error_widget.dart';
import 'package:snap_shop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:snap_shop/features/notifications/presentation/widgets/notification_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<NotificationsCubit>()..getNotifications(),
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.07),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Notifications',
                      style: Styles.titleText26.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return NotificationCard(notification: notification);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is NotificationsFailure) {
              return CustomErrorWidget(errorMsg: state.message);
            } else {
              return Column(children: [Text('Notifications')]);
            }
          },
        ),
      ),
    );
  }
}
