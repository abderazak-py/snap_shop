import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/product/data/models/product_model.dart';

class SearchRemoteDataSource {
  final ISupabaseService supabaseService;

  SearchRemoteDataSource(this.supabaseService);

  // Fetch all products with their images
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await supabaseService
          .from('products')
          .select(
            'id, created_at, name, description, price, category, image(image_url, position)',
          )
          .order('id', ascending: true);

      return (response as List).map((product) {
        final imagesRaw = product['image'] as List?;
        final imageList = (imagesRaw ?? [])
            .map((img) => img['image_url']?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
        // Important: pass as 'image' key to fit your ProductModel.fromMap
        return ProductModel.fromMap({...product, 'image': imageList});
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  // Search products by name
  Future<Either<Failure, List<ProductModel>>> search(String query) async {
    try {
      final response = await supabaseService
          .from('products')
          .select(
            'id, created_at, name, description, price, category, image(image_url, position)',
          )
          .ilike('name', '%$query%');

      final products = (response as List).map((product) {
        final imagesRaw = product['image'] as List?;
        final imageList = (imagesRaw ?? [])
            .map((img) => img['image_url']?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
        // Important: pass as 'image' key to fit your ProductModel.fromMap
        return ProductModel.fromMap({...product, 'image': imageList});
      }).toList();

      return Right(products);
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }

  // Search products by name, price range, and category
  Future<Either<Failure, List<ProductModel>>> searchWithFilter({
    required String query,
    double? minPrice,
    double? maxPrice,
    String? category,
  }) async {
    try {
      var request = supabaseService.from('products').select();

      // search by name
      if (query.isNotEmpty) {
        request = request.ilike('name', '%$query%');
      }

      // filter by category
      if (category != null && category.isNotEmpty) {
        request = request.eq('category', category);
      }

      // filter by price range
      if (minPrice != null && maxPrice != null) {
        request = request.gte('price', minPrice).lte('price', maxPrice);
      }

      final response = await request;

      final products = (response as List).map((product) {
        final imagesRaw = product['image'] as List?;
        final imageList = (imagesRaw ?? [])
            .map((img) => img['image_url']?.toString() ?? '')
            .where((url) => url.isNotEmpty)
            .toList();
        // Important: pass as 'image' key to fit your ProductModel.fromMap
        return ProductModel.fromMap({...product, 'image': imageList});
      }).toList();

      return Right(products);
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }
}
