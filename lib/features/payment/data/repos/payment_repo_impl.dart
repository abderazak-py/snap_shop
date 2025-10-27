import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:snap_shop/features/payment/domain/entities/order_entity.dart';
import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Map<String, dynamic>>> paypalTransactions() async {
    return await remoteDataSource.paypalTransactions();
  }

  @override
  Future<void> saveOrder() {
    return remoteDataSource.saveOrder();
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    final response = await remoteDataSource.getOrders();
    return response.fold(
      (failure) => Left(failure),
      (orders) => Right(orders.map((order) => order.toEntity()).toList()),
    );
  }
}
