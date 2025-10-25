import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/product/domain/usecases/get_banners_usecase.dart';
import 'package:snap_shop/features/product/presentation/cubit/banner/banner_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/banner_loading.dart';

class ProductBannerSection extends StatelessWidget {
  const ProductBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final width = MediaQuery.sizeOf(context).width;
    final aspectRatio = (9 / 18);
    return SizedBox(
      height: width * aspectRatio + 10,
      width: width,
      child: BlocProvider(
        create: (context) =>
            BannerCubit(getBannersUseCase: sl<GetBannersUseCase>())
              ..getBanners(),
        child: BlocBuilder<BannerCubit, BannerState>(
          builder: (context, state) {
            if (state is BannerSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: width * aspectRatio,
                    width: width,
                    child: PageView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (final banner in state.banners)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: banner.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: state.banners.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: AppColors.kPrimaryColor,
                      dotColor: AppColors.kTextColor2,
                    ),
                  ),
                ],
              );
            } else if (state is BannerFailure) {
              return ErrorWidget(state.error);
            } else {
              return BannerLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
