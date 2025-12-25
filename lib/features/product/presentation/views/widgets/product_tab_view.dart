import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../categories_list_view.dart';
import 'custom_tab_bar.dart';
import 'product_banner_section.dart';
import 'products_list.dart';

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
                        ProductsList(),
                      ],
                    ),
                  ),
                  CategoriesListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
