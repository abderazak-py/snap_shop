import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addOneToCart(int productId);
  Future<Either<Failure, void>> removeOneFromCart(int productId);
  Future<Either<Failure, void>> removeFromCart(int id);
  Future<Either<Failure, List<CartEntity>>> getCartItems();
  Future<Either<Failure, void>> emptyCart();
}
