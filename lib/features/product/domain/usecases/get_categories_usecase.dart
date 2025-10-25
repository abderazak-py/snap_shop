import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';

class GetCategoriesUsecase {
  final ProductRepository repository;

  GetCategoriesUsecase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> execute() async {
    return await repository.getCategories();
  }
}
