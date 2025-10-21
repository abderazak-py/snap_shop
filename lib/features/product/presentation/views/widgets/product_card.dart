import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLoading = Skeletonizer.maybeOf(context)?.enabled ?? false;

    return GestureDetector(
      onTap: () {
        AppRouter.router.push(AppRouter.kProductDetailsView, extra: product);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: isLoading
                ? Skeleton.replace(
                    width: width * 0.43,
                    height: width * 0.43,
                    child: SizedBox.expand(),
                  )
                : Stack(
                    children: [
                      CachedNetworkImage(
                        width: width * 0.43,
                        height: width * 0.43,
                        fit: BoxFit.cover,
                        imageUrl: product.images.isNotEmpty
                            ? product.images.first ?? ''
                            : '',
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: AppColors.kTextColor.withAlpha(90),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () async {
                              context.read<FavoriteCubit>().toggleFavorite(
                                product,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                                buildWhen: (prev, curr) {
                                  bool has(FavoriteState s) =>
                                      s is FavoriteSuccess &&
                                      s.favorite.any(
                                        (e) => e.productId == product.id,
                                      );
                                  return has(prev) != has(curr);
                                },
                                builder: (context, state) {
                                  final isFavorite =
                                      state is FavoriteSuccess &&
                                      state.favorite.any(
                                        (e) => e.productId == product.id,
                                      );
                                  return isFavorite
                                      ? SvgPicture.asset(
                                          AppIcons.favoriteFilled,
                                          width: 18,
                                          colorFilter: ColorFilter.mode(
                                            Colors.red,
                                            BlendMode.srcIn,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          AppIcons.favorite,
                                          width: 18,
                                          colorFilter: ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: width * 0.43,
            child: Text(
              textAlign: TextAlign.center,
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.titleText14.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: Styles.titleText16,
          ),
        ],
      ),
    );
  }
}
