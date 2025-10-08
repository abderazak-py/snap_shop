import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class RemoveFromCartUsecase {
  final CartRepository repository;
  RemoveFromCartUsecase(this.repository);
  Future<void> execute(int id) async {
    await repository.removeFromCart(id);
  }
}
