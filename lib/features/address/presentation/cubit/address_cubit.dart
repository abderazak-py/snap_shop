import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snap_shop/features/address/domain/entities/address_entity.dart';
import 'package:snap_shop/features/address/domain/usecases/add_address_usecase.dart';
import 'package:snap_shop/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    print('starteddddddddd');
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
      print(f.message);
    }, (_) => emit(AddressInitial()));
  }

  Future<void> getAddresses() async {
    emit(AddressLoading());
    final response = await getAddressesUsecase.execute();

    response.fold((f) => emit(AddressFailure(error: f.message)), (addresses) {
      emit(AddressSuccess(addresses: addresses));
    });
  }

  Future<bool> getLocation(List<TextEditingController> controllers) async {
    emit(AddressLoading());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AddressFailure(error: 'Location services are disabled');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(AddressFailure(error: 'Location permissions are denied.'));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        AddressFailure(
          error:
              'Location permissions are permanently denied, we cannot request permissions.',
        ),
      );
      return false;
    }

    final location = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    controllers[0].text = placemarks.first.street ?? '';
    controllers[1].text = placemarks.first.subAdministrativeArea ?? '';
    controllers[2].text = placemarks.first.administrativeArea ?? '';
    controllers[3].text = placemarks.first.postalCode ?? '';
    controllers[4].text = placemarks.first.country ?? '';
    emit(
      AddressLocationSuccess(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
    return true;
  }
}
