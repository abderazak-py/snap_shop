import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AddressCubit>()..getAddresses(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.07),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Addresses',
                style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 10),

            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                if (state is AddressSuccess) {
                  return Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.addresses.length,
                            itemBuilder: (context, index) {
                              final address = state.addresses[index];
                              return Column(
                                children: [
                                  Container(
                                    width: double.infinity,

                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: AppColors.kSecondaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              address.addressText,
                                              style: Styles.titleText20
                                                  .copyWith(
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            ),
                                            Text(
                                              'Biskra, hai Sonthing',
                                              style: Styles.titleText18
                                                  .copyWith(
                                                    color:
                                                        AppColors.kTextColor2,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        CircleAvatar(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 35),
                            child: SizedBox(
                              width: 200,
                              child: CustomBigButton(
                                title: 'Add Address',
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is AddressFailure) {
                  return Center(child: Text(state.error));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
