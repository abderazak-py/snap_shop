import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();

  Future<ProductEntity?> getProductById(int productId);

  Future<List<ProductEntity>> getProductsByCategory(String category);

  Future<List<ProductEntity>> searchProducts(String query);

  Future<void> addProduct(ProductEntity product);

  Future<void> updateProduct(ProductEntity product);

  Future<void> deleteProduct(int productId);
}
