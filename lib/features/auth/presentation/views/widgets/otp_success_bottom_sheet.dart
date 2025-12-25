import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import 'custom_big_button.dart';

class OtpSuccessBottomSheet extends StatelessWidget {
  const OtpSuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 70,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xffdfe2eb),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(height: 40),
        CircleAvatar(
          radius: 80,
          backgroundColor: const Color(0xff00d261).withAlpha(40),
          child: CircleAvatar(
            radius: 55,
            backgroundColor: const Color(0xff00d261),
            child: Icon(Icons.mark_email_read, color: Colors.white, size: 40),
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Register Success',
          style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 5),
        Text(
          textAlign: TextAlign.center,
          'Congratulation your account has been created.\nyou can now use it to snap.',
          style: Styles.titleText14.copyWith(
            color: AppColors.kTextColor2,
            fontWeight: FontWeight.w900,
          ),
        ),
        Spacer(),
        CustomBigButton(
          title: 'Go to Homepage',
          onPressed: () {
            GoRouter.of(context).go(AppRouter.kHomeView);
          },
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
