import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';
import 'package:snap_shop/features/product/domain/usecases/search_products_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final SearchProductsUsecase searchProductsUsecase;
  ProductCubit({
    required this.getProductsUseCase,
    required this.searchProductsUsecase,
  }) : super(ProductInitial());

  //get products
  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final products = await getProductsUseCase.execute();
      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(error: e.toString()));
    }
  }

  //search products
  Future<void> searchProducts(String query) async {
    emit(ProductLoading());
    try {
      final products = await searchProductsUsecase.execute(query);

      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(error: e.toString()));
    }
  }
}
