import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.emailController,
    required this.isLoading,
  });

  final TextEditingController emailController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final email = value?.trim() ?? '';
        if (email.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$',
        ).hasMatch(email)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      style: Styles.titleText16.copyWith(color: AppColors.kTextColor),
      keyboardType: TextInputType.emailAddress,
      controller: emailController,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        hintText: 'Enter your email',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            right: 10,
            bottom: 10,
          ),
          child: SvgPicture.asset(
            AppIcons.mail,
            colorFilter: const ColorFilter.mode(
              AppColors.kTextColor2,
              BlendMode.srcIn,
            ),
          ),
        ),
        hintStyle: Styles.titleText16.copyWith(color: AppColors.kTextColor2),

        fillColor: AppColors.kSecondaryColor,
        filled: true,
        border: customOutlineBorder(),
        enabledBorder: customOutlineBorder(),
        disabledBorder: customOutlineBorder(),
        focusedBorder: customOutlineBorder(color: AppColors.kPrimaryColor),
      ),
      enabled: !isLoading,
    );
  }

  OutlineInputBorder customOutlineBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color ?? Colors.transparent, width: 2),
      gapPadding: 15,
    );
  }
}
