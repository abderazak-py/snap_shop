import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_categories_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends HydratedCubit<CategoryState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  CategoryCubit({required this.getCategoriesUsecase})
    : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    final response = await getCategoriesUsecase.execute();
    response.fold(
      (f) => emit(CategoryFailure(error: f.message)),
      (r) => emit(CategorySuccess(categories: r)),
    );
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    if (type == 'success') {
      final list = (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList();
      return CategorySuccess(categories: list);
    }
    if (type == 'failure') {
      return CategoryFailure(error: json['error'] as String? ?? '');
    }
    return CategoryInitial();
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    if (state is CategorySuccess) {
      return {
        'type': 'success',
        'categories': state.categories.map((c) => c.toJson()).toList(),
      };
    }
    if (state is CategoryFailure) {
      return {'type': 'failure', 'error': state.error};
    }
    return null;
  }
}
