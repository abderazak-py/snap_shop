import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class ProductTopSection extends StatelessWidget {
  const ProductTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        CircleAvatar(radius: 20),
        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Abderazak',
              style: Styles.titleText16.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              'Let\'s go shopping',
              style: Styles.titleText12.copyWith(color: AppColors.kTextColor2),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          padding: EdgeInsets.all(-10),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchProductsView);
          },
          icon: Icon(Icons.search_rounded, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_rounded, size: 30),
        ),
      ],
    );
  }
}
