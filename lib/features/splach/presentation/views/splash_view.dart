import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import 'widgets/splach_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SplachViewBody(),
    );
  }
}
