import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/payment/domain/entities/order_entity.dart';

abstract class PaymentRepository {
  Future<List<Map<String, dynamic>>> paypalTransactions();
  Future<void> saveOrder(int addressId);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
