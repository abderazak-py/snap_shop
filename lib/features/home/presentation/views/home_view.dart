import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:snap_shop/features/cart/presentation/views/cart_view.dart';
import 'package:snap_shop/features/home/presentation/cubit/home_cubit.dart';
import 'package:snap_shop/features/home/presentation/cubit/home_state.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/product_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snap_shop/features/profile/presentation/views/profile_view.dart';

// Cubit class managing an int index state
class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void changeIndex(int newIndex) {
    if (state == newIndex) return;
    emit(newIndex);
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider<CartCubit>(
                  create: (_) => sl<CartCubit>()..getCartItems(),
                ),
                BlocProvider<ProductCubit>(
                  create: (_) => sl<ProductCubit>()..getProducts(),
                ),
              ],
              child: IndexedStack(
                index: state.currentIndex,
                children: [
                  ProductView(),
                  CartView(),
                  Center(child: Text('Favourite')), // Favourite
                  ProfileView(), // Profile
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
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_rounded),
                  label: 'Cart',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded),
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
