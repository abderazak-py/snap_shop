import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class LoginTopSection extends StatelessWidget {
  const LoginTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login Account',
          style: Styles.titleText24.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 8),
        Text(
          'Please login with registred account',
          style: Styles.titleText14.copyWith(color: AppColors.kTextColor2),
        ),
      ],
    );
  }
}
