import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_wide_button.dart';

class ProfileLoading extends StatelessWidget {
  const ProfileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Skeletonizer(
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.08),
            Text(
              'Profile',
              style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
            ),
            Spacer(),
            SizedBox(
              width: width * 0.4,
              child: CircleAvatar(
                radius: 80,
                child: CircleAvatar(
                  radius: 75,
                  child: Skeleton.replace(
                    width: width * 0.4,
                    height: width * 0.4,
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'SnapperYYYY',
              style: Styles.titleText24.copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              'YYYYYYY@YYYYYY.YYY',
              style: Styles.titleText18.copyWith(color: AppColors.kTextColor2),
            ),
            Spacer(),
            for (int i = 0; i < 3; i++)
              CustomWideButton(
                icon: SvgPicture.asset(
                  height: 30,
                  AppIcons.cart,
                  colorFilter: ColorFilter.mode(
                    AppColors.kTextColor,
                    BlendMode.srcIn,
                  ),
                ),
                title: 'YYYYYYYY',
                onPressed: () {},
              ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
