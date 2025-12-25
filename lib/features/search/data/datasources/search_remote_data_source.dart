import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/supabase_service.dart';
import '../../../product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchRemoteDataSource {
  final ISupabaseService supabaseService;

  SearchRemoteDataSource(this.supabaseService);

  // Search products by name or description
  Future<Either<Failure, List<ProductModel>>> search(String query) async {
    try {
      final response = await supabaseService
          .from('products')
          .select('''
          id, 
          created_at, 
          name, 
          description, 
          price, 
          category_id,
          category(id, name, image),
          image(image_url, position)
          ''')
          .or('name.ilike.%$query%,description.ilike.%$query%')
          .order('id', ascending: true);

      final products = (response as List)
          .map((product) => ProductModel.fromMap(product))
          .toList();

      return Right(products);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to search products: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }

  // Search products by name, price range, and categories
  Future<Either<Failure, List<ProductModel>>> searchWithFilters({
    required String query,
    double? minPrice,
    double? maxPrice,
    int? categoryId,
  }) async {
    try {
      var request = supabaseService.from('products').select('''
          id, 
          created_at, 
          name, 
          description, 
          price, 
          category_id,
          category(id, name, image),
          image(image_url, position)
          ''');

      // Search by name
      if (query.isNotEmpty) {
        request = request.ilike('name', '%$query%');
      }

      // Filter by category ID
      if (categoryId != null) {
        request = request.eq('category_id', categoryId);
      }

      // filter by price range
      if (minPrice != null && maxPrice != null) {
        request = request.gte('price', minPrice).lte('price', maxPrice);
      }

      final response = await request.order('id', ascending: true);

      final products = (response as List)
          .map((product) => ProductModel.fromMap(product))
          .toList();

      return Right(products);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to search products: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to search products: ${e.toString()}'));
    }
  }
}
