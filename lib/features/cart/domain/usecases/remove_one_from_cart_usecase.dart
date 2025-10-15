import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class RemoveOneFromCartUsecase {
  final CartRepository repository;
  RemoveOneFromCartUsecase(this.repository);
  Future<Either<Failure, void>> execute(int productId) async {
    final response = await repository.removeOneFromCart(productId);
    return response;
  }
}
