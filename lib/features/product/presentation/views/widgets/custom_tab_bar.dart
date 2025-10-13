import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: AppColors.kTextColor,
      unselectedLabelColor: AppColors.kTextColor2,
      labelStyle: Styles.titleText16.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: Styles.titleText14,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: AppColors.kPrimaryColor),
        insets: EdgeInsets.symmetric(horizontal: -30),
      ),
      tabs: [
        Tab(text: 'Home'),
        Tab(text: 'Category'),
      ],
    );
  }
}
