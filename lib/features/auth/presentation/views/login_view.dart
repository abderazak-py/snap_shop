import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/injection_container.dart';
import '../cubit/auth_cubit.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController(
    text: 'a@gmail.com',
  ); //text: 'a@gmail.com');
  final passwordController = TextEditingController(
    text: '000000',
  ); //text: '000000');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: LoginViewBody(
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}
