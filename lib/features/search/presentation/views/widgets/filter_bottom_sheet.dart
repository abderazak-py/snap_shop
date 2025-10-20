import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/auth/presentation/views/widgets/custom_big_button.dart';
import 'package:snap_shop/features/search/presentation/views/widgets/custom_slider_point.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    this.initial = const RangeValues(5, 500),
  });
  final RangeValues initial;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _values;

  @override
  void initState() {
    super.initState();
    _values = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 70,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xffdfe2eb),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Filter By',
            style: Styles.titleText22.copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  'Price',
                  style: Styles.titleText18.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Text(
                  '\$${_values.start.floor()}-\$${_values.end.floor()}',
                  style: Styles.titleText18.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 1,
              activeTickMarkColor: Colors.transparent,
              inactiveTickMarkColor: Colors.transparent,
              disabledActiveTickMarkColor: Colors.transparent,
              disabledInactiveTickMarkColor: Colors.transparent,
              activeTrackColor: AppColors.kPrimaryColor,
              rangeThumbShape: CustomSliderPoint(),
            ),
            child: RangeSlider(
              values: _values,
              min: 5,
              max: 500,
              divisions: ((500 - 5) / 10).round(),
              onChanged: (v) => setState(() => _values = v),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 50,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: (index != 0)
                        ? AppColors.kSecondaryColor
                        : AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'category',
                      style: Styles.titleText14.copyWith(
                        fontWeight: FontWeight.w700,
                        color: (index != 0)
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 40),

          CustomBigButton(
            title: 'Apply',
            onPressed: () => GoRouter.of(context).pop(_values),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
