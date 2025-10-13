import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/google_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/register_input_section.dart';

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
            GoRouter.of(
              context,
            ).go(AppRouter.kConfirmOtpView, extra: emailController.text);
          } else if (state is AuthSuccessConfirmed) {
            GoRouter.of(context).go(AppRouter.kProductView);
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
                RegisterInputSection(
                  nameController: nameController,
                  isLoading: isLoading,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 70),
                CustomBigButton(
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
                const SizedBox(height: 20),
                GoogleButton(isLoading: isLoading),
              ],
            ),
          );
        },
      ),
    );
  }
}
