import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';

class ErrorWidget extends StatelessWidget {
  final String errorMsg;
  const ErrorWidget({super.key, required this.errorMsg});

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
