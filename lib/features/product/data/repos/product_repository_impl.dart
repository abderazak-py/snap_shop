import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/data/datasources/product_remote_data_source.dart';
import 'package:snap_shop/features/product/data/models/product_model.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    final response = await remoteDataSource.getProducts();
    return response.fold(
      (failure) => Left(failure),
      (products) =>
          Right(products.map((model) => _mapProductToEntity(model)).toList()),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    final response = await remoteDataSource.getProductsByCategory(category);
    return response.fold(
      (failure) => Left(failure),
      (products) =>
          Right(products.map((model) => _mapProductToEntity(model)).toList()),
    );
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int productId) async {
    final response = await remoteDataSource.getProductById(productId);
    return response.fold(
      (failure) => Left(failure),
      (model) => Right(_mapProductToEntity(model)),
    );
  }

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    final response = await remoteDataSource.addProduct(product as dynamic);
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    final response = await remoteDataSource.updateProduct(product as dynamic);
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int productId) async {
    final response = await remoteDataSource.deleteProduct(productId);
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  ProductEntity _mapProductToEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      category: model.category,
      price: model.price,
      createdAt: model.createdAt,
      images: model.images,
    );
  }
}
