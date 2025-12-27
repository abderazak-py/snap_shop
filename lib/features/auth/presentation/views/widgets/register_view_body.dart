import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../cubit/auth_cubit.dart';
import 'register_buttons.dart';
import 'register_input_section.dart';
import 'register_top_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final GlobalKey<FormState> formKey;

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
                  RegisterTopSection(),
                  SizedBox(height: height * 0.04),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        RegisterInputSection(
                          nameController: nameController,
                          isLoading: isLoading,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        const SizedBox(height: 70),
                        RegisterButtons(
                          isLoading: isLoading,
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: formKey,
                        ),
                      ],
                    ),
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
