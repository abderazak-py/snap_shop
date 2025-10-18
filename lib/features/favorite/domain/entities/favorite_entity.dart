import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final int id;
  final DateTime addedAt;
  final int productId;
  final String userId;
  final String productName;
  final double productPrice;
  final String productImage;

  const FavoriteEntity({
    required this.id,
    required this.addedAt,
    required this.productId,
    required this.userId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  List<Object?> get props => [
    id,
    addedAt,
    productId,
    userId,
    productName,
    productPrice,
    productImage,
  ];
}
