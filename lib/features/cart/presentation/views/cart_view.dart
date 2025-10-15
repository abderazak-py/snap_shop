import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'widgets/cart_card.dart';
import 'package:snap_shop/features/cart/presentation/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CartCubit()..getCartItems(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartFailure) {
              return Center(child: Text(state.error));
            } else if (state is CartSuccess) {
              if (state.cart.isEmpty) {
                return const Center(child: Text('No items in cart'));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cart.length,
                      itemBuilder: (context, index) {
                        final product = state.cart[index];
                        return Column(
                          children: [
                            CartCard(product: product),
                            if (index != state.cart.length - 1)
                              Divider(endIndent: 15, indent: 15),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: CustomBigButton(
                      title: 'Order and Pay',
                      onPressed: () {
                        //GoRouter.of(context).push(AppRouter.kPaymentView);
                      },
                    ),
                  ),
                ],
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
