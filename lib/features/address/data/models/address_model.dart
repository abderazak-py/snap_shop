import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/address/domain/entities/address_entity.dart';

class AddressModel extends Equatable {
  final int id;
  final String userId;
  final String addressText;
  final double latitude;
  final double longitude;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.addressText,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      addressText: map['address_text'] ?? '',
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'address_text': addressText,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // If you use clean architecture entities:
  AddressEntity toEntity() => AddressEntity(
    id: id,
    userId: userId,
    addressText: addressText,
    latitude: latitude,
    longitude: longitude,
  );

  @override
  List<Object?> get props => [id, userId, addressText, latitude, longitude];
}
