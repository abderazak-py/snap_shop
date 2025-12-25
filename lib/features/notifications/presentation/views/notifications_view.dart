import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../domain/entities/notification_entity.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/notification_card.dart';

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
                if (state is NotificationsSuccess)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = state.notifications[index];
                        return NotificationCard(notification: notification);
                      },
                    ),
                  )
                else if (state is NotificationsFailure)
                  CustomErrorWidget(errorMsg: state.message)
                else
                  Expanded(
                    child: Skeletonizer(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final notification = NotificationEntity(
                            id: 0,
                            title: 'this a title',
                            body: 'this a placeholder text for body',
                            createdAt: DateTime.now(),
                            userId: 'ss',
                          );
                          return NotificationCard(notification: notification);
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
