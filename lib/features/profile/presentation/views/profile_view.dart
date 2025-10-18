import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/core/widgets/custom_wide_button.dart';
import 'package:snap_shop/features/auth/domain/usecases/get_current_user_usecase.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    //final signOutUseCase = sl<SignOutUseCase>();
    final getCurrentUserUseCase = sl<GetCurrentUserUseCase>();
    return Scaffold(
      body: FutureBuilder(
        future: getCurrentUserUseCase.execute(),
        builder: (context, asyncSnapshot) {
          final user = asyncSnapshot.data;
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
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
                        user?.avatarUrl ?? '',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user?.name?.split(' ').first ?? 'Snapper',
                  style: Styles.titleText24.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  user?.email ?? 'no email',
                  style: Styles.titleText18.copyWith(
                    color: AppColors.kTextColor2,
                  ),
                ),
                Spacer(),
                CustomWideButton(
                  icon: Icon(Icons.shopping_bag_outlined, size: 30),
                  title: 'Cart',
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kCartView);
                  },
                ),
                CustomWideButton(
                  icon: Icon(Icons.discount_outlined, size: 30),
                  title: 'Orders',
                  onPressed: () {},
                ),
                CustomWideButton(
                  icon: Icon(Icons.settings_rounded, size: 30),
                  title: 'Settings',
                  onPressed: () {},
                ),
                CustomWideButton(
                  icon: Icon(Icons.logout_outlined, size: 30),
                  title: 'SignOut',
                  onPressed: () {},
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
