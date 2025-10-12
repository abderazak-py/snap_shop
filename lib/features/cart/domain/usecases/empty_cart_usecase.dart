import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';

class EmptyCartUsecase {
  final CartRepository repository;
  EmptyCartUsecase(this.repository);
  Future<void> execute() async {
    await repository.emptyCart();
  }
}
