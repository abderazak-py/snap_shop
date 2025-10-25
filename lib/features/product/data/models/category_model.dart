import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  // Convert Model to Entity
  CategoryEntity toEntity() {
    return CategoryEntity(id: id, name: name, image: image);
  }

  // Convert Entity to Model
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(id: entity.id, name: entity.name, image: entity.image);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image};
  }

  @override
  List<Object?> get props => [id, name, image];
}
