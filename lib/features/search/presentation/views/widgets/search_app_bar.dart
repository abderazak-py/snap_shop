import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/styles.dart';
import '../../cubit/search_cubit.dart';
import 'filter_bottom_sheet.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  late final TextEditingController _textController;
  late final Timer _debounceTimer;
  String? query;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {});
  }

  @override
  void dispose() {
    _textController.dispose();
    _debounceTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, left: 15, right: 16),
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
              controller: _textController,
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
                    onTap: () async {
                      final result =
                          await showModalBottomSheet<Map<String, dynamic>>(
                            context: context,
                            builder: (_) => FilterBottomSheet(),
                          );
                      if (result != null && context.mounted) {
                        final range = result['range'] as RangeValues;
                        final categoryId = result['category'] as int?;
                        context.read<SearchCubit>().searchWithFilters(
                          query ?? '',
                          minPrice: range.start,
                          maxPrice: range.end,
                          categoryId: categoryId,
                        );
                      }
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
                  query = value;
                  _debounceTimer.cancel();
                  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                    if (context.mounted) {
                      context.read<SearchCubit>().search(value);
                    }
                  });
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
