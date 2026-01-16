import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_big_button.dart';
import '../../../domain/entities/address_entity.dart';
import 'address_card.dart';

class AddressLoading extends StatelessWidget {
  const AddressLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final address = AddressEntity(
                    id: 0,
                    userId: '0',
                    street: 'street street',
                    state: 'state state',
                    city: 'city city',
                    country: 'country',
                    postal: 'postal',
                    latitude: 0,
                    longitude: 0,
                  );
                  return AddressCard(address: address, isLoading: true);
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
                      GoRouter.of(context).push(AppRouter.kAddAddress);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
