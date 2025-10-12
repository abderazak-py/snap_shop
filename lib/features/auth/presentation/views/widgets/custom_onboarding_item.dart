import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class CustomOnboardingItem extends StatelessWidget {
  const CustomOnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: height * 0.45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.titleText22.copyWith(fontWeight: FontWeight.w900),
          maxLines: 2,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: Styles.titleText16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.kTextColor2,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
