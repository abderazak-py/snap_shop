import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final controller = PageController();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.07),
            Row(
              children: [
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => GoRouter.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.kTextColor,
                    size: 30,
                  ),
                ),
                Spacer(),
                Text(
                  'Product Details',
                  style: Styles.titleText20.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => GoRouter.of(context).push(AppRouter.kCartView),
                  child: SvgPicture.asset(
                    width: 30,
                    AppIcons.cart,
                    colorFilter: ColorFilter.mode(
                      AppColors.kTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
            SizedBox(height: height * 0.04),
            SizedBox(
              width: width,
              height:
                  width -
                  60, //if u clone this u can use a variable p for padding and use 2p here
              child: PageView(
                controller: controller,
                children: [
                  for (var image in product.images)
                    if (image != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: product.images.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: AppColors.kPrimaryColor,
                  dotColor: AppColors.kTextColor2,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                product.name,
                style: Styles.titleText22.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                product.category,
                style: Styles.titleText16.copyWith(
                  color: AppColors.kTextColor2,
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Description',
                style: Styles.titleText18.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                product.description,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: Styles.titleText16.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.kTextColor2,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                Text(
                  '\$',
                  style: Styles.titleText12.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                Text(
                  '${product.price}',
                  style: Styles.titleText12.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: width * 0.48,
                  child: CustomBigButton(
                    title: 'Add to Cart',
                    onPressed: () {
                      //TODO add functionality
                    },
                  ),
                ),
                SizedBox(width: width * 0.05),
              ],
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }
}
