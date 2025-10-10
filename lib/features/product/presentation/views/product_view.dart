import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final addToCartUsecase = sl<AddToCartUsecase>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: Styles.titleText16),
        actions: [
          IconButton(
            onPressed: () {
              sl<AuthRepository>().signOut();
              GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kCartView);
            },
            icon: Icon(Icons.shopping_bag),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kSearchProductsView);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => sl<ProductCubit>()..getProducts(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductSuccess) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.kProductDetailsView, extra: product);
                    },
                    title: Text(product.name, style: Styles.titleText16),
                    subtitle: CachedNetworkImage(
                      height: 100,
                      imageUrl: state.products[index].images.first ?? '',
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
              );
            } else if (state is ProductFailure) {
              return Center(child: Text('Filed =${state.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
