import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/email_text_field.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/name_text_field.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/password_text_field.dart';

class RegisterInputSection extends StatelessWidget {
  const RegisterInputSection({
    super.key,
    required this.nameController,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: Styles.titleText18.copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 15),
        NameTextField(nameController: nameController, isLoading: isLoading),
        SizedBox(height: 16),
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
          child: Text(
            'Forgot Password?',
            style: Styles.titleText14.copyWith(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
