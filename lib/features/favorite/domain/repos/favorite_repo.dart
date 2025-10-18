import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/favorite/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> toggleFavorite(int productId);
  Future<Either<Failure, void>> removeFromFavorite(int id);
  Future<Either<Failure, List<FavoriteEntity>>> getFavoriteItems();
}
