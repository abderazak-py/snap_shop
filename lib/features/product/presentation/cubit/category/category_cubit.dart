import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_categories_usecase.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
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
}
