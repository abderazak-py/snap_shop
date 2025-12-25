import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/address_remote_data_source.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repos/address_repo.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addAddress(
    String street,
    String state,
    String city,
    String country,
    int postal,
    double latitude,
    double longitude,
  ) async {
    final response = await remoteDataSource.addAddress(
      street: street,
      state: state,
      city: city,
      country: country,
      postal: postal,
      latitude: latitude,
      longitude: longitude,
    );
    return response.fold((failure) => Left(failure), (_) => Right(null));
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses() async {
    final response = await remoteDataSource.getAddresses();
    return response.fold(
      (failure) => Left(failure),
      (addresses) =>
          Right(addresses.map((address) => address.toEntity()).toList()),
    );
  }
}
