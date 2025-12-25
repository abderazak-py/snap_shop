import 'package:equatable/equatable.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends Equatable {
  final int id;
  final String userId;
  final double total;
  final String currency;
  final double shipping;
  final DateTime createdAt;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.currency,
    required this.shipping,
    required this.createdAt,
    this.items = const [],
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      userId: map['user_id'] as String, // Supabase column
      total: (map['total'] as num).toDouble(),
      currency: map['currency'] as String,
      shipping: (map['shipping'] as num).toDouble(),
      createdAt: DateTime.parse(map['created_at'] as String),
      items: (map['items'] as List<dynamic>? ?? const [])
          .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'total': total,
      'currency': currency,
      'shipping': shipping,
      'created_at': createdAt.toIso8601String(),
      'items': items.map((e) => e.toMap()).toList(),
    };
  }

  OrderEntity toEntity() => OrderEntity(
    id: id,
    userId: userId,
    total: total,
    currency: currency,
    shipping: shipping,
    createdAt: createdAt,
    items: items.map((e) => e.toEntity()).toList(),
  );

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

class OrderItemModel extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String productName;
  final double productPrice;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    final product = map['products'] ?? {};
    return OrderItemModel(
      id: map['id'] as int,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      productName: product['name'] ?? '',
      productPrice: (product['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }

  OrderItemEntity toEntity() => OrderItemEntity(
    id: id,
    orderId: orderId,
    productId: productId,
    quantity: quantity,
    productName: productName,
    productPrice: productPrice,
  );

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
