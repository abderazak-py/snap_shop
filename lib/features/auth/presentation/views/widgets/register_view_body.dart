import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../cubit/auth_cubit.dart';
import 'custom_big_button.dart';
import 'google_button.dart';
import 'register_input_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<AuthCubit>().startOtpTimer();
            GoRouter.of(
              context,
            ).go(AppRouter.kConfirmOtpView, extra: emailController.text);
            emailController.clear();
            passwordController.clear();
            nameController.clear();
          } else if (state is AuthSuccessConfirmed) {
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.1),
                  Text(
                    'Register Account',
                    style: Styles.titleText24.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    'Enter your information to register',
                    style: Styles.titleText14.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  RegisterInputSection(
                    nameController: nameController,
                    isLoading: isLoading,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: CustomBigButton(
                      title: 'Register',
                      onPressed: isLoading
                          ? () {}
                          : () {
                              context.read<AuthCubit>().register(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(child: GoogleButton(isLoading: isLoading)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
