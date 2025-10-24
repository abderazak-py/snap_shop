import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/domain/entities/user_entity.dart';
import 'package:snap_shop/features/auth/domain/usecases/get_current_user_usecase.dart';

class ProductTopSection extends StatelessWidget {
  const ProductTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final getCurrentUserUseCase = sl<GetCurrentUserUseCase>();
    return Row(
      children: [
        SizedBox(width: width * 0.05),
        FutureBuilder(
          future: getCurrentUserUseCase.execute(),
          builder: (context, snapshot) {
            UserEntity? user;
            snapshot.data?.fold((l) {}, (r) => user = r);
            return SizedBox(
              width: width * 0.11,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(50),
                child: (user?.avatarUrl?.isNotEmpty ?? false)
                    ? CachedNetworkImage(imageUrl: user!.avatarUrl!)
                    : const CircleAvatar(
                        radius: 40, // diameter = 80
                        backgroundColor: AppColors.kPrimaryColor,
                      ),
              ),
            );
          },
        ),
        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getCurrentUserUseCase.execute(),
              builder: (context, snapshot) {
                UserEntity? user;
                snapshot.data?.fold((l) {}, (r) => user = r);
                return SizedBox(
                  width: width * 0.5,
                  child: Text(
                    'Hi, ${user?.name ?? 'Snapper'}',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.titleText16.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
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
          padding: EdgeInsets.all(-10),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kSearchProductsView);
          },
          icon: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              right: 10,
              bottom: 10,
            ),

            child: SvgPicture.asset(
              AppIcons.search,

              colorFilter: const ColorFilter.mode(
                AppColors.kTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_rounded, size: 30),
        ),
      ],
    );
  }
}
