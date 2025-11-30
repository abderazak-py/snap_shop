import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/address/data/datasources/address_remote_data_source.dart';
import 'package:snap_shop/features/address/data/models/address_model.dart';
import 'package:snap_shop/features/address/domain/repos/address_repo.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addAddress(
    String addressText,
    double latitude,
    double longitude,
  ) async {
    final response = await remoteDataSource.addAddress(
      addressText: addressText,
      latitude: latitude,
      longitude: longitude,
    );
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    final response = await remoteDataSource.getAddresses();
    return response.fold(
      (failure) => Left(failure),
      (addresses) => Right(addresses),
    );
  }
}
