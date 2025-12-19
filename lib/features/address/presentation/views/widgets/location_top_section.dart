import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/address/presentation/cubit/address_cubit.dart';

class LocationTopSection extends StatelessWidget {
  const LocationTopSection({
    super.key,
    required List<TextEditingController> controllers,
  }) : _controllers = controllers;

  final List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * .15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    context.read<AddressCubit>().getLocation(_controllers);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xff00d261).withAlpha(40),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff00d261),
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
                GestureDetector(
                  onTap: () {
                    //TODO add map picker here
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xff00d261).withAlpha(40),
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
    );
  }
}
