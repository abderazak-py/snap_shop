import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/search_products_usecase.dart';

class SearchProductsView extends StatefulWidget {
  const SearchProductsView({super.key});

  @override
  State<SearchProductsView> createState() => _SearchProductsViewState();
}

class _SearchProductsViewState extends State<SearchProductsView> {
  String? query;
  Future<List<ProductEntity>>? searchFuture;

  @override
  Widget build(BuildContext context) {
    final searchProductsUseCase = sl<SearchProductsUsecase>();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 16, right: 16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                  // Only perform search if query is not empty
                  if (query != null && query!.isNotEmpty) {
                    searchFuture = searchProductsUseCase.execute(query!);
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<ProductEntity>>(
              future: searchFuture,
              builder: (context, snapshot) {
                if (query == null || query!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Enter a search term to find products',
                      style: Styles.titleText16,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Center(child: Text('Searching...')),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: Styles.titleText16,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No products found for "$query"',
                      style: Styles.titleText16,
                    ),
                  );
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).push(AppRouter.kProductDetailsView, extra: product);
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
