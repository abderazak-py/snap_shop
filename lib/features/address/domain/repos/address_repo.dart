import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/address/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<Failure, void>> addAddress(
    String street,
    String state,
    String city,
    String country,
    int postal,
    double latitude,
    double longitude,
  );
  Future<Either<Failure, List<AddressEntity>>> getAddresses();
}
