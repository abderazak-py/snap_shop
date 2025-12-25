import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.passwordController,
    required this.isLoading,
  });

  final TextEditingController passwordController;
  final bool isLoading;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final password = value ?? '';
        if (password.isEmpty) {
          return 'Please enter your password';
        } else if (password.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      controller: widget.passwordController,
      style: Styles.titleText16.copyWith(color: AppColors.kTextColor),
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 10,
            right: 10,
            bottom: 10,
          ),
          child: SvgPicture.asset(
            AppIcons.lock,
            colorFilter: const ColorFilter.mode(
              AppColors.kTextColor2,
              BlendMode.srcIn,
            ),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            right: 20,
            bottom: 10,
          ),
          child: GestureDetector(
            onTap: () => setState(() {
              _hide = !_hide;
            }),
            child: SvgPicture.asset(
              _hide ? AppIcons.eye : AppIcons.eyeOff,
              colorFilter: const ColorFilter.mode(
                AppColors.kTextColor2,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        hintText: 'Enter your password',
        hintStyle: Styles.titleText16.copyWith(color: AppColors.kTextColor2),
        fillColor: AppColors.kSecondaryColor,
        filled: true,
        border: customOutlineBorder(),
        enabledBorder: customOutlineBorder(),
        disabledBorder: customOutlineBorder(),
        focusedBorder: customOutlineBorder(color: AppColors.kPrimaryColor),
      ),

      obscureText: _hide,
      enabled: !widget.isLoading,
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
