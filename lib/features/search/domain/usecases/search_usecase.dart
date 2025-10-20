import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/search/domain/repos/search_repo.dart';

class SearchUsecase {
  final SearchRepository repository;

  SearchUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute(String query) async {
    final response = await repository.search(query);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
