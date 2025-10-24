import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/resend_button.dart';

class OtpButtonsSection extends StatelessWidget {
  const OtpButtonsSection({
    super.key,
    required this.otpControllers,
    required this.email,
  });

  final List<TextEditingController?> otpControllers;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBigButton(
          title: 'Submit',
          onPressed: () {
            String otp = otpControllers.map((c) => c?.text ?? '').join();
            if (otp.length == 6) {
              context.read<AuthCubit>().verifyOtp(otp: otp, email: email);
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('fill all the fields')));
            }
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Didn\'t recive the code? ',
              style: Styles.titleText16.copyWith(
                color: AppColors.kTextColor2,
                fontWeight: FontWeight.w900,
              ),
            ),
            ResendButton(email: email),
          ],
        ),
      ],
    );
  }
}
