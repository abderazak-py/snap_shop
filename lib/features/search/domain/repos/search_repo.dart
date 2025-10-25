import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ProductEntity>>> search(String query);
  Future<Either<Failure, List<ProductEntity>>> searchWithFilters(
    String query,
    double? minPrice,
    double? maxPrice,
    int? categoryId,
  );
}
