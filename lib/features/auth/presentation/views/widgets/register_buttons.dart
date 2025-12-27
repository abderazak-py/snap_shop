import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import 'custom_big_button.dart';
import 'google_button.dart';

class RegisterButtons extends StatelessWidget {
  const RegisterButtons({
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
        Center(
          child: CustomBigButton(
            isLoading: isLoading,
            title: 'Register',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthCubit>().register(
                  emailController.text,
                  passwordController.text,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all fields')),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(child: GoogleButton(isLoading: isLoading)),
      ],
    );
  }
}
