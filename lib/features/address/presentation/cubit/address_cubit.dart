import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/add_address_usecase.dart';
import '../../domain/usecases/get_addresses_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddAddressUsecase addAddressUsecase;
  final GetAddressesUsecase getAddressesUsecase;

  AddressCubit({
    required this.addAddressUsecase,
    required this.getAddressesUsecase,
  }) : super(AddressInitial());

  Future<void> addAddress({
    required String street,
    required String state,
    required String city,
    required String country,
    required int postal,
    required double latitude,
    required double longitude,
  }) async {
    emit(AddressLoading());
    final response = await addAddressUsecase.execute(
      street,
      state,
      city,
      country,
      postal,
      latitude,
      longitude,
    );
    response.fold((f) {
      emit(AddressFailure(error: f.message));
    }, (_) => emit(AddressInitial()));
  }

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final response = await getAddressesUsecase.execute();

    response.fold((f) => emit(AddressFailure(error: f.message)), (addresses) {
      final initialId = addresses.isNotEmpty ? addresses.first.id : null;
      emit(AddressSuccess(addresses: addresses, selectedAddressId: initialId));
    });
  }

  Future<void> getLocation(List<TextEditingController> controllers) async {
    emit(AddressLoading());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AddressFailure(error: 'Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(AddressFailure(error: 'Location permissions are denied.'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        AddressFailure(
          error:
              'Location permissions are permanently denied, we cannot request permissions.',
        ),
      );
    }

    final location = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    final l = placemarks.first;
    controllers[0].text =
        '${l.thoroughfare ?? l.street ?? ''} + ${l.subThoroughfare ?? ''}';
    controllers[1].text = l.subAdministrativeArea ?? l.subLocality ?? '';
    controllers[2].text = l.administrativeArea ?? l.locality ?? '';
    controllers[3].text = l.postalCode ?? '';
    controllers[4].text = l.country ?? '';
    emit(
      AddressLocationSuccess(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
  }

  Future<void> setLocationFromMap(
    PickedData pickedData,
    List<TextEditingController> controllers,
  ) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      pickedData.latLong.latitude,
      pickedData.latLong.longitude,
    );
    final l = placemarks.first;
    controllers[0].text =
        '${l.thoroughfare ?? l.street ?? ''} + ${l.subThoroughfare ?? ''}';
    controllers[1].text = l.subAdministrativeArea ?? l.subLocality ?? '';
    controllers[2].text = l.administrativeArea ?? l.locality ?? '';
    controllers[3].text = l.postalCode ?? '';
    controllers[4].text = l.country ?? '';
    emit(
      AddressLocationSuccess(
        latitude: pickedData.latLong.latitude,
        longitude: pickedData.latLong.longitude,
      ),
    );
  }

  void selectAddress(int addressId) {
    if (state is AddressSuccess) {
      final currentState = state as AddressSuccess;
      emit(currentState.copyWith(selectedAddressId: addressId));
    }
  }
}
