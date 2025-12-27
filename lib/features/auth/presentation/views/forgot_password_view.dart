import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../cubit/auth_cubit.dart';
import 'widgets/custom_big_button.dart';
import 'widgets/email_text_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final TextEditingController emailController = TextEditingController();
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthOtpSuccess) {
              context.read<AuthCubit>().startOtpTimer();
              GoRouter.of(
                context,
              ).go(AppRouter.kConfirmOtpView, extra: emailController.text);
            } else if (state is AuthFailure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              });
            }
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.09),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: Styles.titleText30.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please enter your email address to receive a verification code',
                        style: Styles.titleText20.copyWith(
                          color: AppColors.kTextColor2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.15),

                  EmailTextField(
                    emailController: emailController,
                    isLoading: state is AuthLoading,
                  ),

                  SizedBox(height: height * 0.04),
                  Center(
                    child: CustomBigButton(
                      isLoading: state is AuthLoading,
                      title: 'Send Code',
                      onPressed: () {
                        context.read<AuthCubit>().signInWithOtp(
                          email: emailController.text,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
