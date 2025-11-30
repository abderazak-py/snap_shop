import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/address/data/models/address_model.dart';

abstract class AddressRepository {
  Future<Either<Failure, void>> addAddress(
    String addressText,
    double latitude,
    double longitude,
  );
  Future<Either<Failure, List<AddressModel>>> getAddresses();
}
