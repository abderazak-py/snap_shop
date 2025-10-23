import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  //user repository
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );

  //admin repository
  Future<Either<Failure, ProductEntity>> getProductById(int productId);

  Future<Either<Failure, void>> addProduct(ProductEntity product);

  Future<Either<Failure, void>> updateProduct(ProductEntity product);

  Future<Either<Failure, void>> deleteProduct(int productId);
}
