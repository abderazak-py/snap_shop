import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';

class SignoutPopupMenue extends StatelessWidget {
  const SignoutPopupMenue({super.key});

  @override
  Widget build(BuildContext context) {
    final signOutUseCase = sl<SignOutUseCase>();
    return AlertDialog(
      actionsPadding: EdgeInsets.zero,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: GestureDetector(
                  child: Icon(Icons.close_rounded, size: 35),
                  onTap: () => GoRouter.of(context).pop(),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Are you sure you want to\nsign out?',
                textAlign: TextAlign.center,
                style: Styles.titleText16.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: 200,
              child: CustomBigButton(
                onPressed: () => GoRouter.of(context).pop(),
                title: 'Cancel',
              ),
            ),
            SizedBox(height: 5),
            TextButton(
              onPressed: () => signOutUseCase.execute(),
              child: Text(
                'Sign Out',
                style: Styles.titleText18.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ],
    );
  }
}
