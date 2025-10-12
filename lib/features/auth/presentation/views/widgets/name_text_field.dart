import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.nameController,
    required this.isLoading,
  });

  final TextEditingController nameController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final name = value?.trim() ?? '';
        if (name.isEmpty) {
          return 'Please enter your email';
        } else if (name.length < 2) {
          return 'Name must be at least 2 characters long';
        }
        return null;
      },
      style: Styles.titleText16.copyWith(color: AppColors.kTextColor),
      keyboardType: TextInputType.emailAddress,
      controller: nameController,
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
            AppIcons.name,
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
