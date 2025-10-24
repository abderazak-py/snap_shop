import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class ResendButton extends StatefulWidget {
  const ResendButton({super.key, required this.email});
  final String email;

  @override
  State<ResendButton> createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().startOtpTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (prev, curr) => curr is OtpTimerChanged,
      builder: (context, state) {
        if (state is! OtpTimerChanged) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: () {
            if (state.showSendButton) {
              context.read<AuthCubit>().resendOTP(email: widget.email);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('the code has been sent')));
            }
          },
          child: Text(
            state.showSendButton ? 'Resend' : '${state.secondsRemaining}',
            style: Styles.titleText16.copyWith(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
}
