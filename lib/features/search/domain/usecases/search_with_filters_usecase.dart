import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../repos/search_repo.dart';

class SearchWithFiltersUsecase {
  final SearchRepository repository;

  SearchWithFiltersUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute(
    String query,
    double? minPrice,
    double? maxPrice,
    int? categoryId,
  ) async {
    final response = await repository.searchWithFilters(
      query,
      minPrice,
      maxPrice,
      categoryId,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
