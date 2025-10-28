import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/widgets/error_widget.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/entities/image_entity.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.83,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final product = state.products[index];
              return ProductCard(product: product);
            }, childCount: state.products.length),
          );
        } else if (state is ProductFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(errorMsg: state.error),
          );
        } else {
          return Skeletonizer.sliver(
            child: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.83,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = ProductEntity(
                  id: 0,
                  createdAt: DateTime.now(),
                  name: 'Wirless Headphone',
                  description: '',
                  category: CategoryEntity(
                    id: 0,
                    name: 'category',
                    image: 'data:,',
                  ),
                  price: 109.99,
                  images: [ImageEntity(imageUrl: 'data:,', position: 1)],
                  categoryId: 0,
                );
                return ProductCard(product: product);
              }, childCount: 6),
            ),
          );
        }
      },
    );
  }
}
