import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/image_entity.dart';

class ImageModel extends Equatable {
  final String imageUrl;
  final int position;

  const ImageModel({required this.imageUrl, required this.position});

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imageUrl: map['image_url'] as String,
      position: map['position'] as int,
    );
  }

  // Convert Model to Entity
  ImageEntity toEntity() {
    return ImageEntity(imageUrl: imageUrl, position: position);
  }

  // Convert Entity to Model
  factory ImageModel.fromEntity(ImageEntity entity) {
    return ImageModel(imageUrl: entity.imageUrl, position: entity.position);
  }

  Map<String, dynamic> toMap() {
    return {'image_url': imageUrl, 'position': position};
  }

  @override
  List<Object?> get props => [imageUrl, position];
}
