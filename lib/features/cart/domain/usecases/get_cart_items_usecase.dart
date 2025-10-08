import 'package:snap_shop/features/cart/domain/entities/cart_entity.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class GetCartItemsUsecase {
  final CartRepository repository;
  GetCartItemsUsecase(this.repository);
  Future<List<CartEntity>> execute() async {
    return await repository.getCartItems();
  }
}
