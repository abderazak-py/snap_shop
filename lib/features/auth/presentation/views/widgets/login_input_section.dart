import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import 'email_text_field.dart';
import 'password_text_field.dart';

class LoginInputSection extends StatelessWidget {
  const LoginInputSection({
    super.key,
    required this.emailController,
    required this.isLoading,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final bool isLoading;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: Styles.titleText18.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 15),
        EmailTextField(emailController: emailController, isLoading: isLoading),
        SizedBox(height: 16),
        Text(
          'Password',
          style: Styles.titleText18.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 15),
        PasswordTextField(
          passwordController: passwordController,
          isLoading: isLoading,
        ),
        SizedBox(height: 10),
        Align(
          alignment: AlignmentGeometry.topRight,
          child: TextButton(
            onPressed: isLoading
                ? () {}
                : () {
                    GoRouter.of(context).push(
                      AppRouter.kForgotPassword,
                      extra: emailController.text,
                    );
                  },
            child: Text(
              'Forgot Password?',
              style: Styles.titleText14.copyWith(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
