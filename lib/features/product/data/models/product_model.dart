import 'package:equatable/equatable.dart';
import 'category_model.dart';
import 'image_model.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final int categoryId;
  final CategoryModel category;
  final double price;
  final List<ImageModel> images;

  const ProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.category,
    required this.price,
    required this.images,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final imagesRaw = map['image'] as List?;
    final imageList = (imagesRaw ?? [])
        .map((img) => ImageModel.fromMap(img as Map<String, dynamic>))
        .toList();

    final categoryMap = map['category'] as Map<String, dynamic>;
    final category = CategoryModel.fromMap(categoryMap);

    return ProductModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      categoryId: map['category_id'] as int,
      category: category,
      images: imageList,
    );
  }

  // Convert Model to Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      createdAt: createdAt,
      name: name,
      description: description,
      categoryId: categoryId,
      category: category.toEntity(),
      price: price,
      images: images.map((img) => img.toEntity()).toList(),
    );
  }

  // Convert Entity to Model
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      createdAt: entity.createdAt,
      name: entity.name,
      description: entity.description,
      categoryId: entity.categoryId,
      category: CategoryModel.fromEntity(entity.category),
      price: entity.price,
      images: entity.images.map((img) => ImageModel.fromEntity(img)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'category': category.toMap(),
      'image': images.map((img) => img.toMap()).toList(),
    };
  }

  List<ImageModel> get sortedImages {
    final sorted = List<ImageModel>.from(images);
    sorted.sort((a, b) => a.position.compareTo(b.position));
    return sorted;
  }

  String? get mainImageUrl {
    if (images.isEmpty) return null;
    final sorted = sortedImages;
    return sorted.first.imageUrl;
  }

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    description,
    price,
    categoryId,
    category,
    images,
  ];
}
