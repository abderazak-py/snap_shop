import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repos/product_repo.dart';

class GetCategoriesUsecase {
  final ProductRepository repository;

  GetCategoriesUsecase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> execute() async {
    return await repository.getCategories();
  }
}
