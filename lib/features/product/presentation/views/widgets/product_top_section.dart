import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';

class ProductTopSection extends StatelessWidget {
  const ProductTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthSuccessConfirmed) {
              return SizedBox(
                width: width * 0.11,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(50),
                  child: (state.user.avatarUrl?.isNotEmpty ?? false)
                      ? CachedNetworkImage(imageUrl: state.user.avatarUrl!)
                      : const CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.kPrimaryColor,
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            } else if (state is AuthFailure) {
              return Center(child: Text(state.error));
            } else {
              return Center(
                child: Skeletonizer(
                  child: SizedBox(
                    width: width * 0.11,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(50),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.kPrimaryColor,
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),

        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthSuccessConfirmed) {
                  return SizedBox(
                    width: width * 0.5,
                    child: Text(
                      'Hi, ${(state.user.name?.isEmpty ?? true) ? 'Snapper' : state.user.name}',
                      overflow: TextOverflow.ellipsis,
                      style: Styles.titleText16.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  );
                } else if (state is AuthFailure) {
                  return Text(
                    'No user found',
                    style: Styles.titleText16.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  );
                } else {
                  return Skeletonizer(
                    child: SizedBox(
                      width: width * 0.5,
                      child: Text(
                        'Hi, Snapper',
                        overflow: TextOverflow.ellipsis,
                        style: Styles.titleText16.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),

            Text(
              'Let\'s go shopping',
              style: Styles.titleText12.copyWith(color: AppColors.kTextColor2),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchProductsView);
          },
          icon: SvgPicture.asset(
            AppIcons.search,
            colorFilter: const ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kNotificationsView);
          },
          icon: SvgPicture.asset(
            AppIcons.notification,
            colorFilter: const ColorFilter.mode(
              AppColors.kTextColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
