import 'package:flutter/material.dart';
import 'widgets/product_tab_view.dart';
import 'widgets/product_top_section.dart';
import 'widgets/custom_tab_bar.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // Status bar padding
              SliverToBoxAdapter(child: SizedBox(height: height * 0.06)),
              // ProductTopSection
              SliverToBoxAdapter(child: ProductTopSection()),
              // Tab bar that will scroll away
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: const CustomTabBar(),
                ),
              ),
            ];
          },
          body: ProductTabView(),
        ),
      ),
    );
  }
}
