import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/product/data/datasources/product_remote_data_source.dart';
import 'package:snap_shop/features/product/data/models/banner_model.dart';
import 'package:snap_shop/features/product/domain/entities/banner_entity.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
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
      (products) => Right(products.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async {
    final response = await remoteDataSource.getBanners();
    return response.fold(
      (failure) => Left(failure),
      (products) =>
          Right(products.map((model) => _mapBannerToEntity(model)).toList()),
    );
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    final response = await remoteDataSource.getCategories();
    return response.fold(
      (failure) => Left(failure),
      (products) => Right(products.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    int category,
  ) async {
    final response = await remoteDataSource.getProductsByCategory(category);
    return response.fold(
      (failure) => Left(failure),
      (products) => Right(products.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int productId) async {
    final response = await remoteDataSource.getProductById(productId);
    return response.fold(
      (failure) => Left(failure),
      (model) => Right(model.toEntity()),
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

  BannerEntity _mapBannerToEntity(BannerModel model) {
    return BannerEntity(
      id: model.id,
      image: model.image,
      createdAt: model.createdAt,
    );
  }
}
