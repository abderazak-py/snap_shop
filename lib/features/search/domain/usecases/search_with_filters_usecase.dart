import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/search/domain/repos/search_repo.dart';

class SearchWithFiltersUsecase {
  final SearchRepository repository;

  SearchWithFiltersUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute(
    String query,
    double? minPrice,
    double? maxPrice,
    String? category,
  ) async {
    final response = await repository.searchWithFilters(
      query,
      minPrice,
      maxPrice,
      category,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
