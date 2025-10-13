import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/custom_tab_bar.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_banner_section.dart';

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
            BlocProvider(
              create: (context) => sl<ProductCubit>()..getProducts(),
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  AddToCartUsecase addToCartUsecase = sl<AddToCartUsecase>();
                  if (state is ProductSuccess) {
                    return Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              ProductBannerSection(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
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
                              Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) {
                                    final product = state.products[index];
                                    return ListTile(
                                      onTap: () {
                                        GoRouter.of(context).push(
                                          AppRouter.kProductDetailsView,
                                          extra: product,
                                        );
                                      },
                                      title: Text(
                                        product.name,
                                        style: Styles.titleText16,
                                      ),
                                      subtitle: CachedNetworkImage(
                                        height: 100,
                                        imageUrl:
                                            state
                                                .products[index]
                                                .images
                                                .first ??
                                            '',
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      trailing: Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: Styles.titleText16,
                                      ),
                                      leading: IconButton(
                                        onPressed: () {
                                          addToCartUsecase.execute(product.id);
                                        },
                                        icon: Icon(Icons.shopping_bag_rounded),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Center(child: Text('Category Content')),
                        ],
                      ),
                    );
                  } else if (state is ProductFailure) {
                    return Center(child: Text('Filed =${state.error}'));
                  } else {
                    return Center(child: CircularProgressIndicator());
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
