part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final List<AddressEntity> addresses;
  final int? selectedAddressId;

  const AddressSuccess({required this.addresses, this.selectedAddressId});

  @override
  List<Object> get props => [addresses, selectedAddressId].cast<Object>();

  AddressSuccess copyWith({int? selectedAddressId}) {
    return AddressSuccess(
      addresses: addresses,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
    );
  }
}

class AddressLocationSuccess extends AddressState {
  final double latitude;
  final double longitude;

  const AddressLocationSuccess({
    required this.latitude,
    required this.longitude,
  });
}

class AddressFailure extends AddressState {
  final String error;

  const AddressFailure({required this.error});
}
