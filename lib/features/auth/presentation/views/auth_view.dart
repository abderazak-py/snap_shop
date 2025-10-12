import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_onboarding_item.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final controller = PageController();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.65,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: const [
                CustomOnboardingItem(
                  image: AppImages.tech,
                  title: 'Explore Latest Tech Gadgets',
                  description:
                      'Discover innovative electronics and smart devices to upgrade your lifestyle.',
                ),
                CustomOnboardingItem(
                  image: AppImages.kitchen,
                  title: 'Home & Kitchen Essentials',
                  description:
                      'Browse top-quality appliances, cookware, and decor to enhance your living space.',
                ),
                CustomOnboardingItem(
                  image: AppImages.books,
                  title: 'Stationery & Books Collection',
                  description:
                      'Find quality stationery, books, and accessories for work and creativity.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SmoothPageIndicator(controller: controller, count: 3),
          const SizedBox(height: 30),
          CustomBigButton(
            title: 'Create Account',
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kRegisterView);
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kLoginView);
            },
            child: Text(
              'Already have an account?',
              style: Styles.titleText16.copyWith(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
