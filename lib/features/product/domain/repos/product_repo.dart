import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/banner_entity.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  //user repository
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, List<BannerEntity>>> getBanners();

  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    int categoryId,
  );

  //admin repository
  Future<Either<Failure, ProductEntity>> getProductById(int productId);

  Future<Either<Failure, void>> addProduct(ProductEntity product);

  Future<Either<Failure, void>> updateProduct(ProductEntity product);

  Future<Either<Failure, void>> deleteProduct(int productId);
}
