import 'package:snap_shop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class CartRepoImpl extends CartRepository {
  final CartRemoteDataSource remoteDataSource;
  CartRepoImpl(this.remoteDataSource);

  @override
  Future<void> addToCart(int productId) async {
    await remoteDataSource.addToCart(productId);
  }

  @override
  Future<List<CartEntity>> getCartItems() async {
    final cartModel = await remoteDataSource.getCartItems();
    return cartModel
        .map(
          (model) => CartEntity(
            id: model.id,
            addedAt: model.addedAt,
            productId: model.productId,
            userId: model.userId,
            quantity: model.quantity,
            productName: model.productName,
            productPrice: model.productPrice,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeFromCart(int id) async {
    await remoteDataSource.removeFromCart(id);
  }

  @override
  Future<void> emptyCart() async {
    await remoteDataSource.emptyCart();
  }
}
