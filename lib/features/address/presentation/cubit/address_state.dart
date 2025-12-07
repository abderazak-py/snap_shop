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

  const AddressSuccess({required this.addresses});
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
