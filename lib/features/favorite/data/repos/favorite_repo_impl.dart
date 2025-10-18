import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:snap_shop/features/favorite/domain/entities/favorite_entity.dart';
import 'package:snap_shop/features/favorite/domain/repos/favorite_repo.dart';

class FavoriteRepoImpl extends FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;
  FavoriteRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> toggleFavorite(int productId) async {
    final response = await remoteDataSource.toggleFavorite(productId);
    return response;
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavoriteItems() async {
    final result = await remoteDataSource.getFavoriteItems();
    return result.fold(
      (leftValue) => Left(leftValue),
      (rightValue) => Right(
        rightValue
            .map(
              (model) => FavoriteEntity(
                id: model.id,
                addedAt: model.addedAt,
                productId: model.productId,
                userId: model.userId,
                productName: model.productName,
                productPrice: model.productPrice,
                productImage: model.productImage,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, void>> removeFromFavorite(int id) async {
    final response = await remoteDataSource.removeFromFavorite(id);
    return response;
  }
}
