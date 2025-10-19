import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/search_app_bar.dart';

class SearchProductsView extends StatefulWidget {
  const SearchProductsView({super.key});

  @override
  State<SearchProductsView> createState() => _SearchProductsViewState();
}

class _SearchProductsViewState extends State<SearchProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<ProductCubit>(),
        child: Column(
          children: [
            SearchAppBar(),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductSuccess) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
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
                          title: Text(product.name, style: Styles.titleText16),
                          subtitle: Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: Styles.titleText16,
                          ),
                        );
                      },
                    );
                  } else if (state is ProductLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Center(
                      child: Text(
                        'No products available',
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
