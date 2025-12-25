import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/payment_remote_data_source.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repos/payment_repo.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Map<String, dynamic>>> paypalTransactions() async {
    return await remoteDataSource.paypalTransactions();
  }

  @override
  Future<void> saveOrder(int addressId) {
    return remoteDataSource.saveOrder(addressId);
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
