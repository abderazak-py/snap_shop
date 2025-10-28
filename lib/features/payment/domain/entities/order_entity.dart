import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final int id;
  final String userId;
  final double total;
  final String currency;
  final double shipping;
  final DateTime createdAt;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.total,
    required this.currency,
    required this.shipping,
    required this.createdAt,
    required this.items,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    total,
    currency,
    shipping,
    createdAt,
    items,
  ];
}

class OrderItemEntity extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String productName;
  final double productPrice;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
  });

  @override
  List<Object?> get props => [
    id,
    orderId,
    productId,
    quantity,
    productName,
    productPrice,
  ];
}
