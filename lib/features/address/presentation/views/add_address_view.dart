import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/address_text_field.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _postalController;
  late final TextEditingController _countryController;
  late final List<TextEditingController> controllers = [
    _streetController,
    _cityController,
    _stateController,
    _postalController,
    _countryController,
  ];

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _postalController = TextEditingController();
    _countryController = TextEditingController();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (context) => sl<AddressCubit>(),
        child: BlocBuilder<AddressCubit, AddressState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.07),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'Add Address',
                          style: Styles.titleText26.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: height * .08),
                      SizedBox(
                        height: height * .15,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      context.read<AddressCubit>().getLocation(
                                        controllers,
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: const Color(
                                        0xff00d261,
                                      ).withAlpha(40),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: const Color(
                                          0xff00d261,
                                        ),
                                        child: Icon(
                                          Icons.gps_fixed_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'current location',
                                    style: Styles.titleText16.copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(endIndent: 5, indent: 2),
                            Expanded(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: const Color(
                                      0xff00d261,
                                    ).withAlpha(40),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: const Color(0xff00d261),
                                      child: Icon(
                                        Icons.map_rounded,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'from map',
                                    style: Styles.titleText16.copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * .05),
                      AddressTextField(
                        hintText: 'Street',
                        controller: _streetController,
                      ),
                      AddressTextField(
                        hintText: 'City',
                        controller: _cityController,
                      ),
                      AddressTextField(
                        hintText: 'State/Province',
                        controller: _stateController,
                      ),
                      AddressTextField(
                        hintText: 'Postal code',
                        isNumber: true,
                        controller: _postalController,
                      ),
                      AddressTextField(
                        hintText: 'Country',
                        controller: _countryController,
                      ),
                      SizedBox(height: height * .05),
                      Center(
                        child: CustomBigButton(
                          title: 'Save Address',
                          onPressed: () async {
                            if (state is AddressLocationSuccess) {
                              await context.read<AddressCubit>().addAddress(
                                street: _streetController.text,
                                city: _cityController.text,
                                state: _stateController.text,
                                postal: toInt(_postalController.text) ?? 0,
                                country: _countryController.text,
                                latitude: state.latitude,
                                longitude: state.longitude,
                              );
                            } else {
                              if (state is AddressFailure) {
                                print(state.error);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  if (state is AddressLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
