import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_card.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteFailure) {
            return Center(child: Text(state.error));
          } else if (state is FavoriteSuccess) {
            if (state.favorite.isEmpty) {
              return const Center(child: Text('No items in favorite'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.08),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Favorite',
                    style: Styles.titleText26.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.83,
                    ),
                    itemCount: state.favorite.length,
                    itemBuilder: (context, index) {
                      final product = state.favorite[index];
                      return Column(
                        children: [
                          ProductCard(
                            product: ProductEntity(
                              id: product.productId,
                              createdAt: product.addedAt,
                              name: product.productName,
                              description: '',
                              category: '',
                              price: product.productPrice,
                              images: [product.productImage],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
