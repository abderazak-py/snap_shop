import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final int quantity;

  const CartModel({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.quantity,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int,
      addedAt: DateTime.parse(map['added_at'] as String),
      productId: map['product_id'] as int,
      userId: map['user_id'] as String,
      quantity: map['quantity'] as int,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'added_at': addedAt.toIso8601String(),
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [id, productId, userId, quantity];
}
