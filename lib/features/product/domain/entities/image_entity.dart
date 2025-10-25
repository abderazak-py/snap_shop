import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String imageUrl;
  final int position;

  const ImageEntity({required this.imageUrl, required this.position});

  @override
  List<Object?> get props => [imageUrl, position];
}
