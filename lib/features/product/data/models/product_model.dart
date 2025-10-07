import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String category;
  final double price;

  const ProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'description': description,
      'price': price,
      'category': category,
    };
  }

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    description,
    price,
    category,
  ];
}
