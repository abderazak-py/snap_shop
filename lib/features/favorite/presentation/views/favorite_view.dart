import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../domain/entities/favorite_entity.dart';
import '../cubit/favorite_cubit.dart';
import '../widgets/favorite_grid_view.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.08),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Favorite',
                  style: Styles.titleText26.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              if (state is FavoriteSuccess) ...[
                if (state.favorite.isEmpty) ...[
                  Center(
                    child: Text('No favorite items', style: Styles.titleText20),
                  ),
                ] else ...[
                  Expanded(child: FavoriteGridView(products: state.favorite)),
                ],
              ] else if (state is FavoriteFailure)
                CustomErrorWidget(errorMsg: state.error)
              else
                Expanded(
                  child: Skeletonizer(
                    child: FavoriteGridView(
                      isLoading: true,
                      products: List<FavoriteEntity>.generate(6, (i) {
                        return FavoriteEntity(
                          id: 0,
                          addedAt: DateTime.now(),
                          productId: i,
                          userId: '0',
                          productName: 'produc tName',
                          productPrice: 19.99,
                          productImage: 'data:,',
                        );
                      }),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
