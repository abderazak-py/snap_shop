import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class RegisterTopSection extends StatelessWidget {
  const RegisterTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register Account',
          style: Styles.titleText24.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 8),

        Text(
          'Enter your information to register',
          style: Styles.titleText14.copyWith(color: AppColors.kTextColor2),
        ),
      ],
    );
  }
}
