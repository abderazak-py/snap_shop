import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class ConfirmOtpView extends StatelessWidget {
  const ConfirmOtpView({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              GoRouter.of(context).pushReplacement(AppRouter.kProductView);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Confirm Otp', style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsetsGeometry.all(70),
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Enter Otp'),
                    onSubmitted: (value) {
                      context.read<AuthCubit>().verifyOtp(
                        otp: value,
                        email: email,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
