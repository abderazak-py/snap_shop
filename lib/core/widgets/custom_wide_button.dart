import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/styles.dart';

class CustomWideButton extends StatelessWidget {
  const CustomWideButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });
  final Widget icon;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Color.fromARGB(255, 226, 226, 226),
              width: 1,
            ),
          ),
          backgroundColor: AppColors.kSecondaryColor,
          foregroundColor: AppColors.kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          elevation: 0, // removes drop shadow
          shadowColor: Colors.transparent, // ensure no colored shadow
          fixedSize: Size(width - 40, 60),
          iconColor: AppColors.kTextColor,
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Text(
              title,
              style: Styles.titleText18.copyWith(fontWeight: FontWeight.w900),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.kTextColor2,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}

// CustomBigButton(
//                 title: 'SignOut',
//                 onPressed: () {
//                   // GoRouter.of(context).push(AppRouter.kAuthView);
//                   //           signOutUseCase.execute();
//                 },
//               ),
