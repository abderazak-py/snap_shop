import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> toggleFavorite(int productId);
  Future<Either<Failure, void>> removeFromFavorite(int id);
  Future<Either<Failure, List<FavoriteEntity>>> getFavoriteItems();
}
