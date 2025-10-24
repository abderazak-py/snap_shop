import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int id;
  final DateTime createdAt;
  final String image;

  const BannerModel({
    required this.id,
    required this.createdAt,
    required this.image,
  });

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, createdAt, image];
}
