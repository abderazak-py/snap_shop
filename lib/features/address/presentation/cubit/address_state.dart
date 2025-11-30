part of 'address_cubit.dart';

sealed class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final List<AddressModel> addresses;

  const AddressSuccess({required this.addresses});
}

class AddressFailure extends AddressState {
  final String error;

  const AddressFailure({required this.error});
}
