import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/google_button.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
    required this.width,
  });

  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBigButton(
          title: 'Login',
          onPressed: isLoading
              ? () {}
              : () {
                  context.read<AuthCubit>().login(
                    emailController.text,
                    passwordController.text,
                  );
                },
        ), // add loading in the button
        SizedBox(height: 20),
        Text('OR', style: Styles.titleText16),
        SizedBox(height: 20),
        GoogleButton(isLoading: isLoading),
        SizedBox(height: 20),
        CustomBigButton(
          title: 'Register',
          onPressed: () => GoRouter.of(context).push(AppRouter.kRegisterView),
        ),
      ],
    );
  }
}
