import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/payment/domain/entities/order_entity.dart';
import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';

class GetOrdersUsecase {
  final PaymentRepository repository;
  GetOrdersUsecase(this.repository);
  Future<Either<Failure, List<OrderEntity>>> execute() async {
    final response = await repository.getOrders();
    return response;
  }
}
