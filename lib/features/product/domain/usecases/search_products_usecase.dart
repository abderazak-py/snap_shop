import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';

class SearchProductsUsecase {
  final ProductRepository repository;

  SearchProductsUsecase(this.repository);

  Future<List<ProductEntity>> execute(String query) async {
    return await repository.searchProducts(query);
  }
}
