import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final int id;
  final DateTime createdAt;
  final String image;

  const BannerEntity({
    required this.id,
    required this.createdAt,
    required this.image,
  });

  factory BannerEntity.fromJson(Map<String, dynamic> json) {
    return BannerEntity(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'image': image,
    };
  }

  @override
  List<Object?> get props => [id, createdAt, image];
}
