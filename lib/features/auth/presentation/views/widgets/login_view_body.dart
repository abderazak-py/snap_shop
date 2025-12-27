import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../cubit/auth_cubit.dart';
import 'login_buttons.dart';
import 'login_input_section.dart';
import 'login_top_section.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
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
                children: [
                  SizedBox(height: height * 0.07),
                  LoginTopSection(),
                  SizedBox(height: height * 0.04),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
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
