import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'widgets/cart_card.dart';
import 'package:snap_shop/features/cart/presentation/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<CartCubit>()..getCartItems(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartFailure) {
              return Center(child: Text(state.error));
            } else if (state is CartSuccess) {
              if (state.cart.isEmpty) {
                return const Center(child: Text('No items in cart'));
              }
              return Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: height * 0.07),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.cart.length,
                        itemBuilder: (context, index) {
                          final product = state.cart[index];
                          return Column(
                            children: [
                              if (index == 0)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    bottom: 15,
                                  ),
                                  child: Align(
                                    alignment: AlignmentGeometry.centerLeft,
                                    child: Text(
                                      'Cart',
                                      style: Styles.titleText30.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              CartCard(product: product),
                              if (index != state.cart.length - 1)
                                const Divider(endIndent: 15, indent: 15),
                              if (index == state.cart.length - 1)
                                const SizedBox(
                                  height: 300,
                                ), //to make cart scrollable even if the screen is not full, scrolling is fun
                            ],
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: SizedBox(
                          width: 200,
                          child: CustomBigButton(
                            title: 'Order and Pay',
                            onPressed: () => GoRouter.of(
                              context,
                            ).push(AppRouter.kPaymentView),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
