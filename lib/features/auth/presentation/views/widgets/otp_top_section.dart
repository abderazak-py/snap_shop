import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class OtpTopSection extends StatelessWidget {
  const OtpTopSection({super.key, required this.height, required this.email});

  final double height;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 80,
          child: CircleAvatar(
            radius: 55,
            backgroundColor: AppColors.kPrimaryColor,
            child: Icon(Icons.mark_email_read, color: Colors.white, size: 40),
          ),
        ),
        SizedBox(height: height * 0.05),
        Text(
          'Verification Code',
          style: Styles.titleText30.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 15),
        Text(
          'We have sent to verification code to',
          style: Styles.titleText16.copyWith(
            color: AppColors.kTextColor2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          email,
          style: Styles.titleText16.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
