import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product/product_cubit.dart';
import 'widgets/product_card.dart';

class AllProductView extends StatelessWidget {
  const AllProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ProductCubit>()..getProducts()),
          BlocProvider(
            create: (context) => sl<FavoriteCubit>()..getFavoriteItems(),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.08),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Products',
                style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.83,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    );
                  } else if (state is ProductFailure) {
                    return SliverToBoxAdapter(
                      child: CustomErrorWidget(errorMsg: state.error),
                    );
                  } else {
                    return Skeletonizer(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.83,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
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
