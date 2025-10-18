import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('name: ${product.name}'),
            Text('description: ${product.description}'),
            Text('price: ${product.price}'),
            Text('category: ${product.category}'),
            Text('createdAt: ${product.createdAt}'),
            CachedNetworkImage(imageUrl: product.images.first ?? ''),
          ],
        ),
      ),
    );
  }
}
//TODO add this inside product detailes view ,and make this section for adding favorite

                            // try {
                            //   addOneToCartUsecase.execute(product.id);
                            //   context.read<CartCubit>().getCartItems();
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: const Text('Product added to cart'),
                            //       behavior: SnackBarBehavior.floating,
                            //       margin: const EdgeInsets.all(12),
                            //       backgroundColor: AppColors.kPrimaryColor,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       duration: const Duration(seconds: 2),
                            //     ),
                            //   );
                            // } catch (e) {
                            //   debugPrint(e.toString());
                            // }
