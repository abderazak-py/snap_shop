import 'package:snap_shop/features/payment/data/datasources/payment_remote_data_source.dart';
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
}
