import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/favorite_repo.dart';

class ToggleFavoriteeUsecase {
  final FavoriteRepository repository;
  ToggleFavoriteeUsecase(this.repository);
  Future<Either<Failure, void>> execute(int productId) async {
    final response = await repository.toggleFavorite(productId);
    return response;
  }
}
