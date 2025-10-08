import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class AddToCartUsecase {
  final CartRepository repository;
  AddToCartUsecase(this.repository);
  Future<void> execute(int productId) async {
    await repository.addToCart(productId);
  }
}
