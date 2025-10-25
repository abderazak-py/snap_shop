// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/favorite/domain/entities/favorite_entity.dart';
import 'package:snap_shop/features/favorite/domain/usecases/get_favorite_items_usecase.dart';
import 'package:snap_shop/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoriteItemsUsecase getFavoriteItemsUsecase;
  final ToggleFavoriteeUsecase addToFavoriteUsecase;
  FavoriteCubit({
    required this.getFavoriteItemsUsecase,
    required this.addToFavoriteUsecase,
  }) : super(FavoriteInitial());

  void getFavoriteItems() async {
    final response = await getFavoriteItemsUsecase.execute();
    response.fold(
      (failure) => emit(FavoriteFailure(failure.message)),
      (favorite) => emit(FavoriteSuccess(favorite)),
    );
  }

  Future<void> toggleFavorite(ProductEntity product) async {
    final favorite = FavoriteEntity(
      productId: product.id,
      id: 0,
      addedAt: DateTime.now(),
      userId: '',
      productName: product.name,
      productPrice: product.price,
      productImage: product.images.first.imageUrl,
    );
    if (state is! FavoriteSuccess) return;

    final current = List.of((state as FavoriteSuccess).favorite);
    final isFav = current.any((e) => e.productId == favorite.productId);

    // update the ui before talking to the server cuz its slooow and i dont want to use realtime cuz lets save resources
    if (isFav) {
      emit(
        FavoriteSuccess(
          current.where((e) => e.productId != favorite.productId).toList(),
        ),
      );
    } else {
      emit(FavoriteSuccess([...current, favorite]));
    }

    // Backend call (async)
    final response = await addToFavoriteUsecase.execute(favorite.productId);

    // Revert if failed ===important if the user got bad internet
    response.fold((failure) {
      if (isFav) {
        emit(FavoriteSuccess([...current, favorite]));
      } else {
        emit(
          FavoriteSuccess(
            current.where((e) => e.productId != favorite.productId).toList(),
          ),
        );
      }
    }, (_) => ());
  }
}
