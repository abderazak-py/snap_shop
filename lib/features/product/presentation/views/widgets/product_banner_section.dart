import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductBannerSection extends StatelessWidget {
  const ProductBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    num x =
        MediaQuery.sizeOf(context).width /
        13; //crazy implementation of aspect ratio by ABDERAZAK
    return Column(
      children: [
        SizedBox(
          height: x * 6,
          child: PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            children: [
              Align(
                alignment: AlignmentGeometry.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: x * 5,
                    width: x * 12,
                    color: Colors.red,
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: x * 5,
                    width: x * 12,
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentGeometry.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: x * 5,
                    width: x * 12,
                    color: Colors.green,
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SmoothPageIndicator(controller: controller, count: 3),
      ],
    );
  }
}
