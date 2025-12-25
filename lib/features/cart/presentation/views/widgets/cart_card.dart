import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../cubit/cart_cubit.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.product});

  final CartEntity product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLoading = Skeletonizer.maybeOf(context)?.enabled ?? false;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(width: width * 0.05),
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: isLoading
                ? Skeleton.replace(
                    width: width * 0.22,
                    height: width * 0.22,
                    child: SizedBox.expand(),
                  )
                : CachedNetworkImage(
                    width: width * 0.22,
                    height: width * 0.22,
                    fit: BoxFit.cover,
                    imageUrl: product.productImage,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
          SizedBox(width: width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                SizedBox(
                  width: width * 0.55,
                  child: Text(
                    product.productName,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.titleText16.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: width * 0.6,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.kSecondaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  isLoading
                                      ? null
                                      : context
                                            .read<CartCubit>()
                                            .updateQuantity(
                                              product.productId,
                                              true,
                                            );
                                },
                                child: Icon(
                                  Icons.add_rounded,
                                  color: AppColors.kTextColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            isLoading
                                ? Text(
                                    product.quantity.toString(),
                                    style: Styles.titleText14,
                                  )
                                : BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      final item = state is CartSuccess
                                          ? state.cart.firstWhere(
                                              (e) =>
                                                  e.productId ==
                                                  product.productId,
                                            )
                                          : product;
                                      return Text(
                                        item.quantity.toString(),
                                        style: Styles.titleText14,
                                      );
                                    },
                                  ),

                            SizedBox(width: 15),
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Colors.white,
                              child: GestureDetector(
                                onTap: () => isLoading
                                    ? null
                                    : context.read<CartCubit>().updateQuantity(
                                        product.productId,
                                        false,
                                      ),
                                child: Icon(
                                  Icons.remove_outlined,
                                  color: AppColors.kTextColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$${(product.productPrice * product.quantity).toStringAsFixed(2)}',
                        style: Styles.titleText20.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
