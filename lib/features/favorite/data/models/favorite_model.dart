import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final String productName;
  final double productPrice;
  final String productImage;

  const FavoriteModel({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    final product = map['products'] ?? {};
    final imgs = (product['image'] as List?) ?? const [];
    final first = imgs.isNotEmpty ? imgs.first as Map<String, dynamic> : null;
    return FavoriteModel(
      id: map['id'],
      productId: map['product_id'],
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
    };
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    userId,
    productName,
    productPrice,
    productImage,
  ];
}
