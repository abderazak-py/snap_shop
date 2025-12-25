import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/address_entity.dart';
import '../repos/address_repo.dart';

class GetAddressesUsecase {
  final AddressRepository repository;

  GetAddressesUsecase(this.repository);

  Future<Either<Failure, List<AddressEntity>>> execute() async {
    final response = await repository.getAddresses();
    return response.fold((l) => Left(l), (r) => Right(r));
  }
}
