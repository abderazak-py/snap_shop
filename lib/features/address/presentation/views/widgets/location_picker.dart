import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({
    super.key,
    required List<TextEditingController> controllers,
    required this.addressCubit,
  }) : _controllers = controllers;

  final List<TextEditingController> _controllers;
  final AddressCubit addressCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: FlutterLocationPicker.withConfiguration(
                userAgent: 'SnapShop/1.0.0 (achourabderazak1@gmail.com)',
                onPicked: (pickedData) {
                  addressCubit.setLocationFromMap(pickedData, _controllers);
                  GoRouter.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
