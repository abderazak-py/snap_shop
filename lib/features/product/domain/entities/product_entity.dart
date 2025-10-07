import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String category;
  final double price;

  const ProductEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
  });

  @override
  List<Object?> get props => [
    id,
    createdAt,
    name,
    description,
    category,
    price,
  ];
}
