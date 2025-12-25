import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repos/payment_repo.dart';

class PaypalTransactionsUsecase {
  final PaymentRepository repository;
  PaypalTransactionsUsecase(this.repository);
  Future<Either<Failure, List<Map<String, dynamic>>>> execute() async {
    return await repository.paypalTransactions();
  }
}
