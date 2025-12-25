import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/supabase_service.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRemoteDataSource {
  final ISupabaseService supabaseService;

  ProductRemoteDataSource(this.supabaseService);

  // Fetch all products with their images
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
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
          .order('id', ascending: true);

      final products = (response as List).map((product) {
        return ProductModel.fromMap(product);
      }).toList();

      return Right(products);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch products: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to fetch products: ${e.toString()}'));
    }
  }

  //fetch banner list
  Future<Either<Failure, List<BannerModel>>> getBanners() async {
    try {
      final response = await supabaseService
          .from('banner')
          .select()
          .order('created_at', ascending: false);

      final banners = response
          .map((banner) => BannerModel.fromMap(banner))
          .toList();

      return Right(banners);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch banners: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to fetch banners: ${e.toString()}'));
    }
  }

  // Fetch products by category
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    int categoryId,
  ) async {
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
          .eq('category_id', categoryId)
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
      return Left(
        Failure('Failed to fetch products by category: ${e.message}'),
      );
    } catch (e) {
      return Left(
        Failure('Failed to fetch products by category: ${e.toString()}'),
      );
    }
  }

  // Fetch all categories with image URLs from bucket
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await supabaseService
          .from('category')
          .select('id, name, image')
          .order('id', ascending: true);

      final categories = (response as List).map((category) {
        // Get the bucket path from database
        final imagePath = category['image'] as String;

        // Get public URL from Supabase Storage
        final imageUrl = supabaseService.client.storage
            .from('categories')
            .getPublicUrl(imagePath);

        // Update the image field with the full URL
        return CategoryModel.fromMap({...category, 'image': imageUrl});
      }).toList();

      return Right(categories);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch categories: ${e.message}'));
    } catch (e) {
      return Left(Failure('Failed to fetch categories: ${e.toString()}'));
    }
  }

  // Fetch a single product by ID
  Future<Either<Failure, ProductModel>> getProductById(int productId) async {
    try {
      final response = await supabaseService
          .from('products')
          .select()
          .eq('id', productId)
          .single();
      final product = ProductModel.fromMap(response);
      return Right(product);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to fetch product: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to fetch product: ${e.toString()}'));
    }
  }

  // Add a new product (admin feature)
  Future<Either<Failure, void>> addProduct(ProductModel product) async {
    try {
      await supabaseService
          .from('products')
          .insert(product.toMap())
          .select()
          .single();
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to add product: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to add product: ${e.toString()}'));
    }
  }

  // Update an existing product (admin feature)
  Future<Either<Failure, void>> updateProduct(ProductModel product) async {
    try {
      await supabaseService
          .from('products')
          .update(product.toMap())
          .eq('id', product.id)
          .select()
          .single();
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to update product: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to update product: ${e.toString()}'));
    }
  }

  // Delete a product (admin feature)
  Future<Either<Failure, void>> deleteProduct(int productId) async {
    try {
      await supabaseService.from('products').delete().eq('id', productId);
      return const Right(null);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to delete product: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to delete product: ${e.toString()}'));
    }
  }
}
