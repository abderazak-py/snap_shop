import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/otp_buttons_section.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/otp_top_section.dart';

class ConfirmOtpView extends StatefulWidget {
  const ConfirmOtpView({super.key, required this.email});
  final String email;

  @override
  State<ConfirmOtpView> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends State<ConfirmOtpView> {
  List<TextEditingController?> otpControllers = [];

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              successBottomSheet(context);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.15),
                  OtpTopSection(height: height, email: widget.email),
                  OtpTextField(
                    handleControllers: (controllers) =>
                        otpControllers = controllers,
                    alignment: Alignment.center,
                    fieldHeight: 100,
                    fieldWidth: 50,
                    textStyle: Styles.titleText26.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                    showFieldAsBox: true,
                    numberOfFields: 6,
                    borderColor: AppColors.kSecondaryColor,
                    showCursor: true,
                    contentPadding: EdgeInsets.only(top: -10, bottom: 50),
                    borderRadius: BorderRadius.circular(12),
                    cursorColor: AppColors.kPrimaryColor,
                  ),
                  const SizedBox(height: 50),
                  OtpButtonsSection(
                    otpControllers: otpControllers,
                    email: widget.email,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> successBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      constraints: BoxConstraints.expand(),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 70,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xffdfe2eb),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 40),
            CircleAvatar(
              radius: 80,
              backgroundColor: const Color(0xff00d261).withAlpha(40),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xff00d261),
                child: Icon(
                  Icons.mark_email_read,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Register Success',
              style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              'Congratulation your account has been created.\nyou can now use it to snap.',
              style: Styles.titleText14.copyWith(
                color: AppColors.kTextColor2,
                fontWeight: FontWeight.w900,
              ),
            ),
            Spacer(),
            CustomBigButton(
              title: 'Go to Homepage',
              onPressed: () {
                GoRouter.of(context).go(AppRouter.kProductView);
              },
            ),
            SizedBox(height: 50),
          ],
        );
      },
    );
  }
}
