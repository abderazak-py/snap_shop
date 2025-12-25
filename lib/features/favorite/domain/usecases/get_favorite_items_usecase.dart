import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/favorite_entity.dart';
import '../repos/favorite_repo.dart';

class GetFavoriteItemsUsecase {
  final FavoriteRepository repository;
  GetFavoriteItemsUsecase(this.repository);
  Future<Either<Failure, List<FavoriteEntity>>> execute() async {
    final response = await repository.getFavoriteItems();
    return response;
  }
}
