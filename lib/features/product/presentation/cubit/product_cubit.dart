import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  ProductCubit({required this.getProductsUseCase}) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final products = await getProductsUseCase.execute();
      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductFailure(error: e.toString()));
    }
  }
}
