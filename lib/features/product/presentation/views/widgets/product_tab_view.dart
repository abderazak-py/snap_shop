import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../categories_list_view.dart';
import 'product_banner_section.dart';
import 'products_list.dart';

class ProductTabView extends StatelessWidget {
  const ProductTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // Tab 1 inner CustomScrollView linked to NestedScrollView
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kAllProductView);
                      },
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
            ProductsList(),
          ],
        ),

        // Tab 2  also needs its own CustomScrollView
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [SliverToBoxAdapter(child: CategoriesListView())],
        ),
      ],
    );
  }
}
