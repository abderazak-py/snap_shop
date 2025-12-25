import '../repos/payment_repo.dart';

class PaypalTransactionsUsecase {
  final PaymentRepository repository;
  PaypalTransactionsUsecase(this.repository);
  Future<List<Map<String, dynamic>>> execute() async {
    return await repository.paypalTransactions();
  }
}
