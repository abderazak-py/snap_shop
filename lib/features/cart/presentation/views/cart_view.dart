import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/core/widgets/error_widget.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/presentation/views/widgets/cart_list_view.dart';
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.07),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Notifications',
                    style: Styles.titleText26.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (state is CartSuccess)
                  CartListView(cart: state.cart)
                else if (state is CartFailure)
                  CustomErrorWidget(errorMsg: state.error)
                else if (state is CartSuccess)
                  Expanded(
                    child: Skeletonizer(
                      child: CartListView(
                        isLoading: true,
                        cart: List<CartEntity>.generate(6, (i) {
                          return CartEntity(
                            id: i,
                            addedAt: DateTime.now().add(Duration(days: i)),
                            productId: i,
                            userId: '0',
                            productName: 'produc tName',
                            productPrice: 19.99,
                            productImage: 'data:,',
                            quantity: 10,
                          );
                        }),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
