import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../cubit/address_cubit.dart';
import '../../../auth/presentation/views/widgets/custom_big_button.dart';

class SelectAddressView extends StatelessWidget {
  const SelectAddressView({super.key});

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
                'Select Address',
                style: Styles.titleText26.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<AddressCubit, AddressState>(
              builder: (context, state) {
                if (state is AddressSuccess) {
                  return Flexible(
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
                                  GestureDetector(
                                    onTap: () => context
                                        .read<AddressCubit>()
                                        .selectAddress(address.id),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color:
                                              (address.id ==
                                                  state.selectedAddressId)
                                              ? AppColors.kPrimaryColor
                                              : AppColors.kSecondaryColor,
                                          width:
                                              (address.id ==
                                                  state.selectedAddressId)
                                              ? 3
                                              : 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                address.state,
                                                style: Styles.titleText20
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              Text(
                                                '${address.city}, ${address.country}',
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
                                title: state.selectedAddressId == null
                                    ? 'Add Address'
                                    : 'Pay Now',
                                onPressed: () {
                                  if (state.selectedAddressId == null) {
                                    GoRouter.of(
                                      context,
                                    ).push(AppRouter.kAddAddress);
                                  }
                                  GoRouter.of(context).push(
                                    AppRouter.kPaymentView,
                                    extra: state.selectedAddressId,
                                  );
                                },
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
