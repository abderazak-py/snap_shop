import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/styles.dart';
import '../../cubit/auth_cubit.dart';
import 'custom_big_button.dart';
import 'google_button.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBigButton(
          title: 'Login',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthCubit>().login(
                emailController.text,
                passwordController.text,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all the fields')),
              );
            }
          },
        ),
        SizedBox(height: 20),
        Text('OR', style: Styles.titleText16),
        SizedBox(height: 20),
        GoogleButton(isLoading: isLoading),
        SizedBox(height: 20),
        CustomBigButton(
          title: 'Register',
          onPressed: () => GoRouter.of(context).push(AppRouter.kRegisterView),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
