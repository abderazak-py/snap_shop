import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../repos/search_repo.dart';

class SearchUsecase {
  final SearchRepository repository;

  SearchUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute(String query) async {
    final response = await repository.search(query);
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
