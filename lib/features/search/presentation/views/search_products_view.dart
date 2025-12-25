import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../product/domain/entities/category_entity.dart';
import '../../../product/domain/entities/image_entity.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../../product/presentation/views/widgets/product_card.dart';
import '../cubit/search_cubit.dart';
import 'widgets/search_app_bar.dart';

class SearchProductsView extends StatelessWidget {
  const SearchProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SearchCubit>(),
        child: Column(
          children: [
            SearchAppBar(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    if (state.products.isEmpty) {
                      return Center(
                        child: Text(
                          'No Products Found',
                          style: Styles.titleText16,
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.83,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    );
                  } else if (state is SearchFailure) {
                    return CustomErrorWidget(errorMsg: state.error);
                  } else if (state is SearchLoading) {
                    return Skeletonizer(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.83,
                        ),
                        itemCount: 6,

                        itemBuilder: (context, index) {
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
                            images: [
                              ImageEntity(imageUrl: 'data:,', position: 1),
                            ],
                            categoryId: 0,
                          );
                          return ProductCard(product: product);
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Enter  a keyword to search',
                        style: Styles.titleText16,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
