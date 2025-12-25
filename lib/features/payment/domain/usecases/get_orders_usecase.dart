import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../repos/payment_repo.dart';

class GetOrdersUsecase {
  final PaymentRepository repository;
  GetOrdersUsecase(this.repository);
  Future<Either<Failure, List<OrderEntity>>> execute() async {
    final response = await repository.getOrders();
    return response;
  }
}
