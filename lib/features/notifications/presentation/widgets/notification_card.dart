import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/notification_entity.dart';
import '../cubit/notifications_cubit.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.kSecondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                notification.title,
                style: Styles.titleText24.copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => context
                    .read<NotificationsCubit>()
                    .deleteNotification(notification.id),
                child: Icon(Icons.close_rounded, size: 23),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            notification.body,
            style: Styles.titleText18.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.kTextColor2,
            ),
          ),
        ],
      ),
    );
  }
}
