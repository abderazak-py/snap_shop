import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';
import 'package:snap_shop/features/address/presentation/views/widgets/address_text_field.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LocationBottomSection extends StatelessWidget {
  const LocationBottomSection({
    super.key,
    required List<TextEditingController> controllers,
  }) : _controllers = controllers;

  final List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final List<String> fieldHints = [
      'Street',
      'City',
      'State/Province',
      'Postal code',
      'Country',
    ];
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                AddressTextField(
                  isEnabled: (state is AddressLocationSuccess),
                  hintText: fieldHints[i],
                  controller: _controllers[i],
                  isNumber: (i == 3),
                ),

              SizedBox(height: height * .05),
              CustomBigButton(
                title: 'Save Address',
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    if (state is AddressLocationSuccess) {
                      await context.read<AddressCubit>().addAddress(
                        street: _controllers[0].text,
                        city: _controllers[1].text,
                        state: _controllers[2].text,
                        postal: toInt(_controllers[3].text) ?? 0,
                        country: _controllers[4].text,
                        latitude: state.latitude,
                        longitude: state.longitude,
                      );
                    } else {
                      if (state is AddressFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
