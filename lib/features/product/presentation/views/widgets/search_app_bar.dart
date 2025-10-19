import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/product/presentation/views/widgets/filter_bottom_sheet.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90, left: 15, right: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.kTextColor,
              size: 30,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              style: Styles.titleText16.copyWith(color: AppColors.kTextColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                hintText: 'i\'m looking for...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: SvgPicture.asset(
                    AppIcons.search,

                    colorFilter: const ColorFilter.mode(
                      AppColors.kTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 20,
                    bottom: 10,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (_) => FilterBottomSheet(),
                      );
                    },
                    child: SvgPicture.asset(
                      AppIcons.filter,
                      colorFilter: const ColorFilter.mode(
                        AppColors.kTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                hintStyle: Styles.titleText16.copyWith(
                  color: AppColors.kTextColor2,
                ),

                fillColor: AppColors.kSecondaryColor,
                filled: true,
                border: customOutlineBorder(),
                enabledBorder: customOutlineBorder(),
                disabledBorder: customOutlineBorder(),
                focusedBorder: customOutlineBorder(
                  color: AppColors.kPrimaryColor,
                  width: 2,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<ProductCubit>().searchProducts(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder customOutlineBorder({Color? color, double? width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: color ?? AppColors.kTextColor2,
        width: width ?? 0.7,
      ),
      gapPadding: 15,
    );
  }
}
