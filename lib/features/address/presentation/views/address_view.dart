import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../cubit/address_cubit.dart' hide AddressLoading;
import '../../../../core/widgets/custom_big_button.dart';
import 'widgets/address_card.dart';
import 'widgets/address_loading.dart';

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
                              return AddressCard(address: address);
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
                                onPressed: () {
                                  GoRouter.of(
                                    context,
                                  ).push(AppRouter.kAddAddress);
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
                  return AddressLoading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
