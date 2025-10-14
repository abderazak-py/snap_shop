import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLoading = Skeletonizer.maybeOf(context)?.enabled ?? false;
    //AddToCartUsecase addToCartUsecase = sl<AddToCartUsecase>();
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
              : CachedNetworkImage(
                  width: width * 0.43,
                  height: width * 0.43,
                  fit: BoxFit.cover,
                  imageUrl: product.images.first ?? '',
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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

    // ListTile(
    //   onTap: () {
    //     GoRouter.of(
    //       context,
    //     ).push(AppRouter.kProductDetailsView, extra: product);
    //   },
    //   title: Text(product.name, style: Styles.titleText16),
    //   subtitle: CachedNetworkImage(
    //     height: 100,
    //     imageUrl: product.images.first ?? '',
    //     errorWidget: (context, url, error) => const Icon(Icons.error),
    //   ),
    //   trailing: Text(
    //     '\$${product.price.toStringAsFixed(2)}',
    //     style: Styles.titleText16,
    //   ),
    //   leading: IconButton(
    //     onPressed: () {
    //       addToCartUsecase.execute(product.id);
    //     },
    //     icon: Icon(Icons.shopping_bag_rounded),
    //   ),
    // );
  }
}
