import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/address/data/models/address_model.dart';
import 'package:snap_shop/features/address/domain/usecases/add_address_usecase.dart';
import 'package:snap_shop/features/address/domain/usecases/get_addresses_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddAddressUsecase addAddressUsecase;
  final GetAddressesUsecase getAddressesUsecase;

  AddressCubit({
    required this.addAddressUsecase,
    required this.getAddressesUsecase,
  }) : super(AddressInitial());

  Future<void> addAddress({
    required String addressText,
    required double latitude,
    required double longitude,
  }) async {
    emit(AddressLoading());
    final response = await addAddressUsecase.execute(
      addressText,
      latitude,
      longitude,
    );
    response.fold((f) => emit(AddressFailure(error: f.message)), (_) => null);
  }

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final response = await getAddressesUsecase.execute();
    response.fold((f) => emit(AddressFailure(error: f.message)), (addresses) {
      emit(AddressSuccess(addresses: addresses));
    });
  }
}
