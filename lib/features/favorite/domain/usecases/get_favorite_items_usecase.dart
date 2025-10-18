import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/favorite/domain/entities/favorite_entity.dart';
import 'package:snap_shop/features/favorite/domain/repos/favorite_repo.dart';

class GetFavoriteItemsUsecase {
  final FavoriteRepository repository;
  GetFavoriteItemsUsecase(this.repository);
  Future<Either<Failure, List<FavoriteEntity>>> execute() async {
    final response = await repository.getFavoriteItems();
    return response;
  }
}
