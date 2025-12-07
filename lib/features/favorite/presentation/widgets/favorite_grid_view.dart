import 'package:flutter/material.dart';
import 'package:snap_shop/features/favorite/domain/entities/favorite_entity.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/entities/image_entity.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_card.dart';

class FavoriteGridView extends StatelessWidget {
  final List<FavoriteEntity> products;
  final bool isLoading;
  const FavoriteGridView({
    super.key,
    required this.products,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.83,
      ),
      itemCount: isLoading ? 6 : products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Column(
          children: [
            ProductCard(
              product: ProductEntity(
                id: product.productId,
                createdAt: product.addedAt,
                name: product.productName,
                description: '',
                category: CategoryEntity(id: 0, name: '', image: ''),
                price: product.productPrice,
                images: [
                  ImageEntity(imageUrl: product.productImage, position: 1),
                ],
                categoryId: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}
