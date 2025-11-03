import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/widgets/error_widget.dart';
import 'package:snap_shop/features/notifications/presentation/cubit/notifications_cubit.dart';

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
                children: [
                  SizedBox(height: height * 0.07),
                  Text('Notifications'),
                  Text(state.notifications.length.toString()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.notifications[index].title),
                          subtitle: Text(state.notifications[index].body),
                        );
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
