import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/widgets/error_widget.dart';
import '../cubit/category/category_cubit.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoryCubit>()..getCategories(),
      child: SingleChildScrollView(
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return Column(
              children: [
                if (state is CategorySuccess)
                  ...state.categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () => GoRouter.of(
                          context,
                        ).push(AppRouter.kCategoryView, extra: category),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: category.image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  })
                else if (state is CategoryFailure)
                  CustomErrorWidget(errorMsg: state.error)
                else
                  Skeletonizer(
                    child: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: AspectRatio(
                              aspectRatio: 2.5 / 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
