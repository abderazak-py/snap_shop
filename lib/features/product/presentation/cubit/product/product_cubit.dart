import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_by_category_usecase.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductsByCategoryUsecase getProductsByCategoryUsecase;
  ProductCubit({
    required this.getProductsUseCase,
    required this.getProductsByCategoryUsecase,
  }) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    final response = await getProductsUseCase.execute();
    response.fold(
      (f) => emit(ProductFailure(error: f.message)),
      (r) => emit(ProductSuccess(products: r)),
    );
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(ProductLoading());
    final response = await getProductsByCategoryUsecase.execute(categoryId);
    response.fold(
      (f) => emit(ProductFailure(error: f.message)),
      (r) => emit(ProductSuccess(products: r)),
    );
  }
}
