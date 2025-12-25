import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repos/product_repo.dart';

class GetProductsByCategoryUsecase {
  final ProductRepository repository;

  GetProductsByCategoryUsecase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> execute(int categoryId) async {
    return await repository.getProductsByCategory(categoryId);
  }
}
