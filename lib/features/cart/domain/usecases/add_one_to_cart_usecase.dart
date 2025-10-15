import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class AddOneToCartUsecase {
  final CartRepository repository;
  AddOneToCartUsecase(this.repository);
  Future<Either<Failure, void>> execute(int productId) async {
    final response = await repository.addOneToCart(productId);
    return response;
  }
}
