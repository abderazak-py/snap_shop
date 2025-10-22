import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/core/widgets/custom_wide_button.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.07),
            Row(
              children: [
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => GoRouter.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.kTextColor,
                    size: 30,
                  ),
                ),
                Spacer(),
                Text(
                  'Settings',
                  style: Styles.titleText20.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 25),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Account',
                  style: Styles.titleText24.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.name,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Edit Profile',
              onPressed: () {},
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.lock,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Change Password',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 25, top: 15),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Preferences',
                  style: Styles.titleText24.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.language,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Language',
              onPressed: () {},
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.notification,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Notifications',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 25, top: 15),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Security',
                  style: Styles.titleText24.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.pin,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Pin Code',
              onPressed: () {},
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.biometric,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Biometrics',
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 25, top: 15),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'About',
                  style: Styles.titleText24.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.version,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Version Info',
              onPressed: () {},
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.shield,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Legal and Polices',
              onPressed: () {},
            ),
            CustomWideButton(
              icon: SvgPicture.asset(
                height: 30,
                AppIcons.help,
                colorFilter: ColorFilter.mode(
                  AppColors.kTextColor,
                  BlendMode.srcIn,
                ),
              ),
              title: 'Contact Support',
              onPressed: () {},
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
