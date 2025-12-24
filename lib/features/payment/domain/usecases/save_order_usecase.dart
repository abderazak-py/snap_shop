import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';

class SaveOrderUsecase {
  final PaymentRepository repository;

  SaveOrderUsecase(this.repository);
  Future<void> execute({required int addressId}) async {
    await repository.saveOrder(addressId);
  }
}
