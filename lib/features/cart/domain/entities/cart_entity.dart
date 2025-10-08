import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final int quantity;

  const CartEntity({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, addedAt, productId, userId, quantity];
}
