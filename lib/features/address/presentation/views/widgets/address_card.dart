import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entities/address_entity.dart';
import '../../cubit/address_cubit.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address, this.isLoading = false});

  final AddressEntity address;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 0, top: 20, bottom: 20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.kSecondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.state,
                overflow: TextOverflow.ellipsis,
                style: Styles.titleText20.copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                address.street,
                overflow: TextOverflow.ellipsis,
                style: Styles.titleText18.copyWith(
                  color: AppColors.kTextColor2,
                ),
              ),
            ],
          ),
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 100,
              height: 70,
              child: isLoading
                  ? Skeleton.replace(
                      width: 100,
                      height: 70,
                      child: SizedBox.expand(),
                    )
                  : FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                          address.latitude,
                          address.longitude,
                        ),
                        initialZoom: 15,
                        //This locks the map so it acts like an image
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.abderazak.snap_shop',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(
                                address.latitude,
                                address.longitude,
                              ),
                              width: 30,
                              height: 30,
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              switch (value) {
                // case 'edit':
                //   Navigator.of(context).pushNamed(AppRouter.kEditAddress,
                //       arguments: address);
                //   break;
                case 'delete':
                  context.read<AddressCubit>().deleteAddress(address.id);
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Center(
                    child: Text(
                      'Edit',
                      style: Styles.titleText16.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Center(
                    child: Text(
                      'Delete',
                      style: Styles.titleText16.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
