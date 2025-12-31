import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../auth/domain/entities/user_entity.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection({super.key, required this.width, required this.user});

  final double width;
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Profile',
          style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: height * 0.04),
        SizedBox(
          width: width * 0.4,
          child: CircleAvatar(
            radius: 80,
            child: CircleAvatar(
              radius: 75,
              backgroundImage: CachedNetworkImageProvider(user.avatarUrl ?? ''),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          user.name ?? 'Snapper',
          style: Styles.titleText24.copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          user.email,
          style: Styles.titleText18.copyWith(color: AppColors.kTextColor2),
        ),
      ],
    );
  }
}
