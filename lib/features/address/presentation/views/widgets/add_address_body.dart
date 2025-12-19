import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/location_bottom_section.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/location_top_section.dart';

class AddAddressBody extends StatelessWidget {
  const AddAddressBody({
    super.key,
    required List<TextEditingController> controllers,
  }) : _controllers = controllers;
  final List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
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
    );
  }
}
