import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';
import '../utils/styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMsg;
  const CustomErrorWidget({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppIcons.error,
          width: 200,
          colorFilter: ColorFilter.mode(AppColors.kTextColor, BlendMode.srcIn),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            errorMsg,
            style: Styles.titleText16,
          ),
        ),
      ],
    );
  }
}
