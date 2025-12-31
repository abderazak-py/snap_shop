import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_wide_button.dart';
import 'signout_popup_menue.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWideButton(
          icon: SvgPicture.asset(
            height: 30,
            AppIcons.cart,
            colorFilter: ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: 'Cart',
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kCartView);
          },
        ),
        CustomWideButton(
          icon: SvgPicture.asset(
            height: 30,
            AppIcons.orders,
            colorFilter: ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: 'Orders',
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kOrdersView);
          },
        ),
        CustomWideButton(
          icon: SvgPicture.asset(
            height: 30,
            AppIcons.address,
            colorFilter: ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: 'Addresses',
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kAddress);
          },
        ),
        CustomWideButton(
          icon: SvgPicture.asset(
            height: 30,
            AppIcons.settings,
            colorFilter: ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: 'Settings',
          onPressed: () => GoRouter.of(context).push(AppRouter.kSettingsView),
        ),
        CustomWideButton(
          icon: SvgPicture.asset(
            height: 30,
            AppIcons.logout,
            colorFilter: ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
          title: 'Log Out',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SignoutPopupMenue();
              },
            );
          },
        ),
      ],
    );
  }
}
