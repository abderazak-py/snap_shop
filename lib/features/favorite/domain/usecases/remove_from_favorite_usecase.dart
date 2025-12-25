import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/favorite_repo.dart';

class RemoveFromFavoriteUsecase {
  final FavoriteRepository repository;
  RemoveFromFavoriteUsecase(this.repository);
  Future<Either<Failure, void>> execute(int id) async {
    final response = await repository.removeFromFavorite(id);
    return response;
  }
}
