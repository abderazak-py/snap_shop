import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<void> addToCart(int productId);
  Future<void> removeFromCart(int id);
  Future<List<CartEntity>> getCartItems();
}
