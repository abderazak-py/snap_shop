import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLoading = Skeletonizer.maybeOf(context)?.enabled ?? false;
    AddToCartUsecase addToCartUsecase = sl<AddToCartUsecase>();
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16),
          child: isLoading
              ? Skeleton.replace(
                  width: width * 0.43,
                  height: width * 0.43,
                  child: SizedBox.expand(),
                )
              : Stack(
                  children: [
                    CachedNetworkImage(
                      width: width * 0.43,
                      height: width * 0.43,
                      fit: BoxFit.cover,
                      imageUrl: product.images.first ?? '',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: AppColors.kTextColor.withAlpha(90),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            try {
                              addToCartUsecase.execute(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Product added to cart'),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(12),
                                  backgroundColor: AppColors.kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: width * 0.43,
          child: Text(
            textAlign: TextAlign.center,
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.titleText14.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Styles.titleText16,
        ),
      ],
    );
  }
}
