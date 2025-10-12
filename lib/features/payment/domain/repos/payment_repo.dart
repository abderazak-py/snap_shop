abstract class PaymentRepository {
  Future<List<Map<String, dynamic>>> paypalTransactions();
  Future<void> saveOrder();
}
