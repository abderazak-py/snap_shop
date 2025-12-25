import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../chat/presentation/views/chat.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../../favorite/presentation/views/favorite_view.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../../../product/presentation/cubit/product/product_cubit.dart';
import '../../../product/presentation/views/product_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../profile/presentation/views/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
        BlocProvider<FavoriteCubit>(
          create: (_) => sl<FavoriteCubit>()..getFavoriteItems(),
        ),
        BlocProvider<ProductCubit>(
          create: (_) => sl<ProductCubit>()..getProducts(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<FavoriteCubit>(
                  create: (_) => sl<FavoriteCubit>()..getFavoriteItems(),
                ),
                BlocProvider<ProductCubit>(
                  create: (_) => sl<ProductCubit>()..getProducts(),
                ),
                BlocProvider<AuthCubit>(
                  create: (_) => sl<AuthCubit>()..getUser(),
                ),
              ],
              child: IndexedStack(
                index: state.currentIndex,
                children: [
                  ProductView(),
                  FavoriteView(),
                  ChatPage(), //ai chat
                  ProfileView(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: AppColors.kTextColor2,
              selectedItemColor: AppColors.kPrimaryColor,
              currentIndex: state.currentIndex,
              onTap: (newIndex) =>
                  context.read<HomeCubit>().changeIndex(newIndex),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.home,
                    colorFilter: ColorFilter.mode(
                      (state.currentIndex == 0)
                          ? AppColors.kPrimaryColor
                          : AppColors.kTextColor2,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.favorite,
                    colorFilter: ColorFilter.mode(
                      (state.currentIndex == 1)
                          ? AppColors.kPrimaryColor
                          : AppColors.kTextColor2,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.chat,
                    colorFilter: ColorFilter.mode(
                      (state.currentIndex == 2)
                          ? AppColors.kPrimaryColor
                          : AppColors.kTextColor2,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.name,
                    colorFilter: ColorFilter.mode(
                      (state.currentIndex == 3)
                          ? AppColors.kPrimaryColor
                          : AppColors.kTextColor2,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'My Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
