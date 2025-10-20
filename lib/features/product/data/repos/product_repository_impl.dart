import 'package:snap_shop/features/product/data/datasources/product_remote_data_source.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final productModels = await remoteDataSource.getProducts();
    return productModels
        .map(
          (model) => ProductEntity(
            id: model.id,
            name: model.name,
            description: model.description,
            category: model.category,
            price: model.price,
            createdAt: model.createdAt,
            images: model.images,
          ),
        )
        .toList();
  }

  @override
  Future<ProductEntity?> getProductById(int productId) async {
    final productModel = await remoteDataSource.getProductById(productId);
    if (productModel == null) return null;
    return ProductEntity(
      id: productModel.id,
      name: productModel.name,
      description: productModel.description,
      category: productModel.category,
      price: productModel.price,
      createdAt: productModel.createdAt,
      images: productModel.images,
    );
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final productModels = await remoteDataSource.getProductsByCategory(
      category,
    );
    return productModels
        .map(
          (model) => ProductEntity(
            id: model.id,
            name: model.name,
            description: model.description,
            category: model.category,
            price: model.price,
            createdAt: model.createdAt,
            images: model.images,
          ),
        )
        .toList();
  }

  @override
  Future<void> addProduct(ProductEntity product) async {
    await remoteDataSource.addProduct(product as dynamic);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    await remoteDataSource.updateProduct(product as dynamic);
  }

  @override
  Future<void> deleteProduct(int productId) async {
    await remoteDataSource.deleteProduct(productId);
  }
}
