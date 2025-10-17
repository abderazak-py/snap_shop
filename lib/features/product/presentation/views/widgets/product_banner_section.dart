import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snap_shop/core/utils/constants.dart';

class ProductBannerSection extends StatelessWidget {
  const ProductBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final width = MediaQuery.sizeOf(
      context,
    ).width; //crazy implementation of aspect ratio by ABDERAZAK
    return SizedBox(
      height: width * 9 / 21 + 10,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: width * 9 / 21,
            width: width,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/500/200',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/500/200',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/500/200',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColors.kPrimaryColor,
              dotColor: AppColors.kTextColor2,
            ),
          ),
        ],
      ),
    );
  }
}
