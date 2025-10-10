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
          ],
        ),
      ),
    );
  }
}
