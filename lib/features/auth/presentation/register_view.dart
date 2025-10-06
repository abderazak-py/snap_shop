import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    GoRouter.of(
                      context,
                    ).pushReplacement(AppRouter.kProductView);
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().register(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    child: Text('Register', style: Styles.titleText16),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                },
                child: Text('Go To Login', style: Styles.titleText16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
