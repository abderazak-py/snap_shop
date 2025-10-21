import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/product/data/models/product_model.dart';

class SearchRemoteDataSource {
  final ISupabaseService supabaseService;

  SearchRemoteDataSource(this.supabaseService);

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
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }

  // Search products by name, price range, and categoryS
  Future<Either<Failure, List<ProductModel>>> searchWithFilters({
    required String query,
    double? minPrice,
    double? maxPrice,
    String? category,
  }) async {
    try {
      var request = supabaseService
          .from('products')
          .select(
            'id, created_at, name, description, price, category, image(image_url, position)',
          );

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
      if (response.isEmpty) {
        return Right([]);
      }

      return Right(products);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }
}
