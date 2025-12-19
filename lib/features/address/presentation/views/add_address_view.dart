import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/location_bottom_section.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/location_top_section.dart';

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
  late final List<TextEditingController> _controllers = [
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
    for (var controller in _controllers) {
      controller.dispose();
    }
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
                      LocationTopSection(controllers: _controllers),
                      SizedBox(height: height * .05),
                      LocationBottomSection(controllers: _controllers),
                    ],
                  ),
                  if (state is AddressLoading)
                    Positioned.fill(
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
