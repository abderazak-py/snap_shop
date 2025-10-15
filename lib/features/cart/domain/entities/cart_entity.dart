import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final int quantity;
  final String productName;
  final double productPrice;
  final String productImage;
  final bool isSelected;

  const CartEntity({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.isSelected = false,
  });

  CartEntity copyWith({
    int? id,
    DateTime? addedAt,
    int? productId,
    String? userId,
    int? quantity,
    String? productName,
    double? productPrice,
    String? productImage,
    bool? isSelected,
  }) {
    return CartEntity(
      id: id ?? this.id,
      addedAt: addedAt ?? this.addedAt,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
    id,
    addedAt,
    productId,
    userId,
    quantity,
    productName,
    productPrice,
    productImage,
    isSelected,
  ];
}
