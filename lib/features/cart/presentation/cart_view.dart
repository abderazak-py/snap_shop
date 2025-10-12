import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final getCartItemsUsecase = sl<GetCartItemsUsecase>();

    return Scaffold(
      body: FutureBuilder<List<CartEntity>>(
        future: getCartItemsUsecase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Styles.titleText16,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No products available', style: Styles.titleText16),
            );
          } else {
            final products = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        title: Text(
                          'id=${product.id}, name= ${product.productName}, price=${product.productPrice}',
                          style: Styles.titleText16,
                        ),
                        subtitle: Text('quantity is ${product.quantity}'),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kPaymentView);
                  },
                  child: Text('Order and Pay'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
