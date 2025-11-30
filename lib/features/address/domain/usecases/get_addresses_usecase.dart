import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/features/address/data/models/address_model.dart';
import 'package:snap_shop/features/address/domain/repos/address_repo.dart';

class GetAddressesUsecase {
  final AddressRepository repository;

  GetAddressesUsecase(this.repository);

  Future<Either<Failure, List<AddressModel>>> execute() async {
    final response = await repository.getAddresses();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
