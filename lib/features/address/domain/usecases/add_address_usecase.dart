import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/address/domain/repos/address_repo.dart';

class AddAddressUsecase {
  final AddressRepository repository;

  AddAddressUsecase(this.repository);

  Future<Either<Failure, void>> execute(
    String addressText,
    double latitude,
    double longitude,
  ) async {
    final response = await repository.addAddress(
      addressText,
      latitude,
      longitude,
    );
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
