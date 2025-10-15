import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final int quantity;
  final String productName;
  final double productPrice;
  final String productImage;

  const CartModel({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    final product = map['products'] ?? {};
    final imgs = (product['image'] as List?) ?? const [];
    final first = imgs.isNotEmpty ? imgs.first as Map<String, dynamic> : null;
    return CartModel(
      id: map['id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      userId: map['user_id'],
      addedAt: DateTime.parse(map['added_at']),
      productName: product['name'] ?? '',
      productPrice: (product['price'] as num?)?.toDouble() ?? 0.0,
      productImage: first?['image_url']?.toString() ?? '',
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
  List<Object?> get props => [
    id,
    productId,
    userId,
    quantity,
    productName,
    productPrice,
    productImage,
  ];
}
