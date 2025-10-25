import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/entities/image_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final int categoryId;
  final CategoryEntity category;
  final double price;
  final List<ImageEntity> images;

  const ProductEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.category,
    required this.price,
    required this.images,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    description,
    categoryId,
    category,
    price,
    images,
  ];
}
