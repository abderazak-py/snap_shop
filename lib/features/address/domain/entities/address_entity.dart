// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int id;
  final String userId;
  final String street;
  final String state;
  final String city;
  final String country;
  final int postal;
  final double latitude;
  final double longitude;

  const AddressEntity({
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
