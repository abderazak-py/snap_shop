import 'package:flutter/material.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_tab_view.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/product_top_section.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.06),
          ProductTopSection(),
          SizedBox(height: height * 0.02),
          ProductTabView(),
        ],
      ),
    );
  }
}
