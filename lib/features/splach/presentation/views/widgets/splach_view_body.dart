import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/domain/usecases/is_user_signed_in_usecase.dart';
import 'package:snap_shop/features/splach/presentation/views/widgets/sliding_text.dart';

class SplachViewBody extends StatefulWidget {
  const SplachViewBody({super.key});

  @override
  State<SplachViewBody> createState() => _SplachViewBodyState();
}

class _SplachViewBodyState extends State<SplachViewBody> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(flex: 6),
        Text(
          'Snap Shop',
          style: Styles.titleText40.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 10),
        Center(child: SlidingText()),
        Spacer(flex: 10),
        Text(
          'Version 0.1.0 alpha',
          style: Styles.titleText14.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () async {
      final isUserSignedInUsecase = sl<IsUserSignedInUsecase>();
      bool? isUserSignedIn;
      final response = await isUserSignedInUsecase.execute();
      response.fold((l) {
        //TODO make a snckbar here
        return;
      }, (b) => isUserSignedIn = b);
      if (mounted) {
        if (isUserSignedIn ?? false) {
          GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        } else {
          GoRouter.of(context).pushReplacement(AppRouter.kAuthView);
        }
      }
    });
  }
}
