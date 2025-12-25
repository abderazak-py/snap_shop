import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> addOneToCart(int productId);
  Future<Either<Failure, void>> removeOneFromCart(int productId);
  Future<Either<Failure, void>> removeFromCart(int id);
  Future<Either<Failure, List<CartEntity>>> getCartItems();
  Future<Either<Failure, void>> emptyCart();
}
