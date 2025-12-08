import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class AddressTextField extends StatelessWidget {
  final String hintText;
  final bool isNumber;
  final TextEditingController controller;
  const AddressTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          if (isNumber) {
            if (int.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
          } else {
            if (value.length < 2) {
              return 'Please enter a valid value';
            }
          }
          return null;
        },
        controller: controller,
        keyboardType: isNumber
            ? TextInputType.number
            : TextInputType.streetAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          hintText: hintText,
          hintStyle: Styles.titleText16.copyWith(color: AppColors.kTextColor2),
          fillColor: AppColors.kSecondaryColor,
          filled: true,
          border: customOutlineBorder(),
          enabledBorder: customOutlineBorder(),
          disabledBorder: customOutlineBorder(),
          focusedBorder: customOutlineBorder(color: AppColors.kPrimaryColor),
        ),
      ),
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
