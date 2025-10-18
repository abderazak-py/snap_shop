import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/favorite/domain/repos/favorite_repo.dart';

class ToggleFavoriteeUsecase {
  final FavoriteRepository repository;
  ToggleFavoriteeUsecase(this.repository);
  Future<Either<Failure, void>> execute(int productId) async {
    final response = await repository.toggleFavorite(productId);
    return response;
  }
}
