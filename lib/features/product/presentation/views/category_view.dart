import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../favorite/presentation/cubit/favorite_cubit.dart';
import '../../domain/entities/category_entity.dart';
import '../cubit/product/product_cubit.dart';
import 'widgets/product_card.dart';

class CategoryView extends StatelessWidget {
  final CategoryEntity category;
  const CategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<ProductCubit>()..getProductsByCategory(category.id),
          ),
          BlocProvider(
            create: (context) => sl<FavoriteCubit>()..getFavoriteItems(),
          ),
        ],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40, top: height * 0.07),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  category.name,
                  style: Styles.titleText30.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductSuccess) {
                  if (state.products.isEmpty) {
                    return CustomErrorWidget(errorMsg: 'No products available');
                  }
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.83,
                      ),
                      padding: EdgeInsets.only(top: 15),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(product: product);
                      },
                    ),
                  );
                } else if (state is ProductFailure) {
                  return CustomErrorWidget(errorMsg: state.error);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
