import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class GetCartItemsUsecase {
  final CartRepository repository;
  GetCartItemsUsecase(this.repository);
  Future<Either<Failure, List<CartEntity>>> execute() async {
    final response = await repository.getCartItems();
    return response;
  }
}
