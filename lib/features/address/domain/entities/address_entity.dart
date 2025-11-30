import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final String userId;
  final String addressText;
  final double latitude;
  final double longitude;

  const AddressEntity({
    required this.id,
    required this.userId,
    required this.addressText,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [id, userId, addressText, latitude, longitude];
}
