import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';
import 'widgets/custom_big_button.dart';
import 'widgets/password_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.07),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              'Reset Password',
              style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          PasswordTextField(
            passwordController: passwordController,
            isLoading: false,
          ),
          PasswordTextField(
            passwordController: confirmPasswordController,
            isLoading: false,
            confirmPassword: passwordController.text,
          ),
          SizedBox(height: 10),
          CustomBigButton(title: 'Resset Password', onPressed: () {}),
        ],
      ),
    );
  }
}
