import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: AppColors.kSecondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        fixedSize: Size(width - 50, 60),
      ),
      child: Text(
        title,
        style: Styles.titleText16.copyWith(color: Colors.white),
      ),
    );
  }
}
