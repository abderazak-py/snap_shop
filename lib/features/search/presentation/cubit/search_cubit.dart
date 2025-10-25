// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/search/domain/usecases/search_usecase.dart';
import 'package:snap_shop/features/search/domain/usecases/search_with_filters_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUsecase searchUsecase;
  final SearchWithFiltersUsecase searchWithFiltersUsecase;
  SearchCubit({
    required this.searchUsecase,
    required this.searchWithFiltersUsecase,
  }) : super(SearchInitial());

  Future<void> search(String query) async {
    emit(SearchLoading());
    final response = await searchUsecase.execute(query);
    response.fold(
      (failure) => emit(SearchFailure(error: failure.message)),
      (products) => emit(SearchSuccess(products: products)),
    );
  }

  Future<void> searchWithFilters(
    String query, {
    double? minPrice,
    double? maxPrice,
    int? categoryId,
  }) async {
    emit(SearchLoading());
    final response = await searchWithFiltersUsecase.execute(
      query,
      minPrice,
      maxPrice,
      categoryId,
    );
    response.fold(
      (failure) => emit(SearchFailure(error: failure.message)),
      (products) => emit(SearchSuccess(products: products)),
    );
  }
}
