import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/search/data/datasources/search_remote_data_source.dart';
import 'package:snap_shop/features/search/domain/repos/search_repo.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<ProductEntity>>> search(String query) async {
    final response = await remoteDataSource.search(query);
    return response.fold(
      (l) => Left(l),
      (model) => Right(model.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchWithFilters(
    String query,
    double? minPrice,
    double? maxPrice,
    int? categoryId,
  ) async {
    final response = await remoteDataSource.searchWithFilters(
      query: query,
      minPrice: minPrice,
      maxPrice: maxPrice,
      categoryId: categoryId,
    );
    return response.fold(
      (l) => Left(l),
      (model) => Right(model.map((model) => model.toEntity()).toList()),
    );
  }
}
