import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/category_view.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/custom_tab_bar.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_banner_section.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_card.dart';

class ProductTabView extends StatelessWidget {
  const ProductTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Column(
          children: [
            CustomTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  SizedBox(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: ProductBannerSection()),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Text(
                                  'New Arrival',
                                  style: Styles.titleText30.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'See All',
                                    style: Styles.titleText14.copyWith(
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        BlocBuilder<ProductCubit, ProductState>(
                          builder: (context, state) {
                            if (state is ProductSuccess) {
                              return SliverGrid(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.83,
                                    ),
                                delegate: SliverChildBuilderDelegate((
                                  context,
                                  index,
                                ) {
                                  final product = state.products[index];
                                  return ProductCard(product: product);
                                }, childCount: state.products.length),
                              );
                            } else if (state is ProductFailure) {
                              return SliverToBoxAdapter(
                                child: Center(
                                  child: Text('Filed =${state.error}'),
                                ),
                              );
                            } else {
                              return Skeletonizer.sliver(
                                child: SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.83,
                                      ),
                                  delegate: SliverChildBuilderDelegate((
                                    context,
                                    index,
                                  ) {
                                    final product = ProductEntity(
                                      id: 0,
                                      createdAt: DateTime.now(),
                                      name: 'Wirless Headphone',
                                      description: '',
                                      category: '',
                                      price: 109.99,
                                      images: ['data:,'],
                                    );
                                    return ProductCard(product: product);
                                  }, childCount: 6),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  CategoryView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
