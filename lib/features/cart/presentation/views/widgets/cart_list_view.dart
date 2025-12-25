import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../auth/presentation/views/widgets/custom_big_button.dart';
import '../../../domain/entities/cart_entity.dart';
import 'cart_card.dart';

class CartListView extends StatelessWidget {
  final List<CartEntity> cart;
  final bool isLoading;
  const CartListView({super.key, required this.cart, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return Column(
                  children: [
                    CartCard(product: product),
                    if (index != cart.length - 1)
                      const Divider(endIndent: 15, indent: 15),
                    if (index == cart.length - 1)
                      const SizedBox(
                        height: 200,
                      ), //to make users scroll and see the last item that covered by the order button
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
                  onPressed: () =>
                      GoRouter.of(context).push(AppRouter.kSelectAddressView),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
