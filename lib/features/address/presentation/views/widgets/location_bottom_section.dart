import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../cubit/address_cubit.dart';
import 'address_text_field.dart';
import '../../../../../core/widgets/custom_big_button.dart';

class LocationBottomSection extends StatelessWidget {
  const LocationBottomSection({
    super.key,
    required List<TextEditingController> controllers,
    required this.formKey,
  }) : _controllers = controllers;

  final List<TextEditingController> _controllers;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
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
                ),
              SizedBox(height: height * .05),
              CustomBigButton(
                title: 'Save Address',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (state is AddressLocationSuccess) {
                      await context.read<AddressCubit>().addAddress(
                        street: _controllers[0].text,
                        city: _controllers[1].text,
                        state: _controllers[2].text,
                        postal: _controllers[3].text,
                        country: _controllers[4].text,
                        latitude: state.latitude,
                        longitude: state.longitude,
                      );
                    }
                    if (context.mounted) {
                      if (state is AddressFailure) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      } else {
                        context.pop();
                        context.pop();
                        await GoRouter.of(
                          context,
                        ).pushReplacement(AppRouter.kAddress);
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
