import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repos/address_repo.dart';

class DeleteAddressUsecase {
  final AddressRepository repository;

  DeleteAddressUsecase(this.repository);

  Future<Either<Failure, void>> execute(int id) async {
    final response = await repository.deleteAddress(id);
    return response.fold((l) => Left(l), (_) => Right(null));
  }
}
