import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            GoRouter.of(context).pushReplacement(
              AppRouter.kConfirmOtpView,
              extra: emailController.text,
            );
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<AuthCubit>().register(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text('Register', style: Styles.titleText16),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          GoRouter.of(context).go(AppRouter.kLoginView);
                        },
                  child: Text(
                    'Already have an account? Login',
                    style: Styles.titleText16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
