import 'package:equatable/equatable.dart';
import '../../domain/entities/address_entity.dart';

class AddressModel extends Equatable {
  final int id;
  final String userId;
  final String street;
  final String state;
  final String city;
  final String country;
  final int postal;
  final double latitude;
  final double longitude;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.street,
    required this.state,
    required this.city,
    required this.country,
    required this.postal,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      street: map['street'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      postal: map['postal'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'street': street,
      'state': state,
      'city': city,
      'country': country,
      'postal': postal,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // If you use clean architecture entities:
  AddressEntity toEntity() => AddressEntity(
    id: id,
    userId: userId,

    latitude: latitude,
    longitude: longitude,
    street: street,
    state: state,
    city: city,
    country: country,
    postal: postal,
  );

  @override
  List<Object?> get props => [
    id,
    userId,
    street,
    state,
    city,
    country,
    postal,
    latitude,
    longitude,
  ];
}
