import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> paypalTransactions();
  Future<void> saveOrder(int addressId);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
