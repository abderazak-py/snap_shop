import 'package:snap_shop/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  //user repository
  Future<List<ProductEntity>> getAllProducts();

  //admin repository
  Future<ProductEntity?> getProductById(int productId);

  Future<List<ProductEntity>> getProductsByCategory(String category);

  Future<void> addProduct(ProductEntity product);

  Future<void> updateProduct(ProductEntity product);

  Future<void> deleteProduct(int productId);
}
