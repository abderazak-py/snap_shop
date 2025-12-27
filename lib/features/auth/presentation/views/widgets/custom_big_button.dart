import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? AppColors.kPrimaryColor.withAlpha(200)
            : AppColors.kPrimaryColor,
        foregroundColor: AppColors.kSecondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        fixedSize: Size(width - 50, 70),
      ),
      child: Text(
        title,
        style: Styles.titleText16.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
