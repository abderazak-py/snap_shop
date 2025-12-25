import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../cubit/auth_cubit.dart';
import 'login_buttons.dart';
import 'login_input_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess || state is AuthSuccessConfirmed) {
            GoRouter.of(context).go(AppRouter.kHomeView);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.07),
                  Text(
                    'Login Account',
                    style: Styles.titleText24.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Please login with registred account',
                    style: Styles.titleText14.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  LoginInputSection(
                    emailController: emailController,
                    isLoading: isLoading,
                    passwordController: passwordController,
                  ),
                  SizedBox(height: 70),
                  LoginButtons(
                    isLoading: isLoading,
                    emailController: emailController,
                    passwordController: passwordController,
                    width: width,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
