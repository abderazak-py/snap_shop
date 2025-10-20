import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_card.dart';
import 'package:snap_shop/features/search/presentation/cubit/search_cubit.dart';
import 'package:snap_shop/features/search/presentation/views/widgets/search_app_bar.dart';

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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.83,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: state.products[index]);
                      },
                    );
                  } else if (state is SearchFailure) {
                    return Center(
                      child: Text(state.error, style: Styles.titleText16),
                    );
                  } else if (state is SearchLoading) {
                    return CircularProgressIndicator();
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
