import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';

class SaveOrderUsecase {
  final PaymentRepository repository;

  SaveOrderUsecase(this.repository);
  Future<void> execute({
    required List<Map<String, dynamic>> transactions,
  }) async {
    await repository.saveOrder();
  }
}
