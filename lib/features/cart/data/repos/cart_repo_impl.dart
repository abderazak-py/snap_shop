import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class CartRepoImpl extends CartRepository {
  final CartRemoteDataSource remoteDataSource;
  CartRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addToCart(int productId) async {
    final response = await remoteDataSource.addToCart(productId);
    return response;
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartItems() async {
    final result = await remoteDataSource.getCartItems();
    return result.fold(
      (leftValue) => Left(leftValue),
      (rightValue) => Right(
        rightValue
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
            .toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, void>> removeFromCart(int id) async {
    final response = await remoteDataSource.removeFromCart(id);
    return response;
  }

  @override
  Future<Either<Failure, void>> emptyCart() async {
    final response = await remoteDataSource.emptyCart();
    return response;
  }
}
