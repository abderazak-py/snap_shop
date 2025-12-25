import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_wide_button.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'widgets/signout_popup_menue.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessConfirmed) {
            return SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.08),
                  Text(
                    'Profile',
                    style: Styles.titleText26.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: width * 0.4,
                    child: CircleAvatar(
                      radius: 80,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: CachedNetworkImageProvider(
                          state.user.avatarUrl ?? '',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.user.name ?? 'Snapper',
                    style: Styles.titleText24.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    state.user.email,
                    style: Styles.titleText18.copyWith(
                      color: AppColors.kTextColor2,
                    ),
                  ),
                  Spacer(),
                  CustomWideButton(
                    icon: SvgPicture.asset(
                      height: 30,
                      AppIcons.cart,
                      colorFilter: ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Cart',
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kCartView);
                    },
                  ),
                  CustomWideButton(
                    icon: SvgPicture.asset(
                      height: 30,
                      AppIcons.orders,
                      colorFilter: ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Orders',
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kOrdersView);
                    },
                  ),
                  CustomWideButton(
                    icon: SvgPicture.asset(
                      height: 30,
                      AppIcons.orders,
                      colorFilter: ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Addresses',
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kAddress);
                    },
                  ),
                  CustomWideButton(
                    icon: SvgPicture.asset(
                      height: 30,
                      AppIcons.settings,
                      colorFilter: ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Settings',
                    onPressed: () =>
                        GoRouter.of(context).push(AppRouter.kSettingsView),
                  ),
                  CustomWideButton(
                    icon: SvgPicture.asset(
                      height: 30,
                      AppIcons.logout,
                      colorFilter: ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: 'Log Out',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SignoutPopupMenue();
                        },
                      );
                    },
                  ),
                  SizedBox(height: 50),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return CustomErrorWidget(errorMsg: state.error);
          } else {
            return Skeletonizer(
              child: SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.08),
                    Text(
                      'Profile',
                      style: Styles.titleText26.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: width * 0.4,
                      child: CircleAvatar(
                        radius: 80,
                        child: CircleAvatar(
                          radius: 75,
                          child: Skeleton.replace(
                            width: width * 0.4,
                            height: width * 0.4,
                            child: SizedBox.expand(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'SnapperYYYY',
                      style: Styles.titleText24.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'YYYYYYY@YYYYYY.YYY',
                      style: Styles.titleText18.copyWith(
                        color: AppColors.kTextColor2,
                      ),
                    ),
                    Spacer(),
                    for (int i = 0; i < 3; i++)
                      CustomWideButton(
                        icon: SvgPicture.asset(
                          height: 30,
                          AppIcons.cart,
                          colorFilter: ColorFilter.mode(
                            AppColors.kTextColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: 'YYYYYYYY',
                        onPressed: () {},
                      ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
