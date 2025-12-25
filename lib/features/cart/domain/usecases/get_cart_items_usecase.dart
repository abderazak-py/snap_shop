import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../repos/cart_repo.dart';

class GetCartItemsUsecase {
  final CartRepository repository;
  GetCartItemsUsecase(this.repository);
  Future<Either<Failure, List<CartEntity>>> execute() async {
    final response = await repository.getCartItems();
    return response;
  }
}
