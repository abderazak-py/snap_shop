import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final getProductsUseCase = sl<GetProductsUseCase>();

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
        ],
      ),
      body: FutureBuilder<List<ProductEntity>>(
        future: getProductsUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Styles.titleText16,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No products available', style: Styles.titleText16),
            );
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name, style: Styles.titleText16),
                  subtitle: Text(product.description),
                  trailing: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Styles.titleText16,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
