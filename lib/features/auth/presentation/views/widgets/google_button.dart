import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/private.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed: isLoading
          ? null
          : () {
              context.read<AuthCubit>().signInWithGoogle(
                webClientId: GoogleAuthConstants.webClientId,
              );
            },
      icon: SvgPicture.asset(AppIcons.google),
      label: Text(
        'Sign in with Google',
        style: Styles.titleText16.copyWith(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: AppColors.kSecondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        fixedSize: Size(width - 50, 70),
      ),
    );
  }
}
