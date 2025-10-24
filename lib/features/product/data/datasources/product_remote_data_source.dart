import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/product/data/models/banner_model.dart';
import 'package:snap_shop/features/product/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRemoteDataSource {
  final ISupabaseService supabaseService;

  ProductRemoteDataSource(this.supabaseService);

  // Fetch all products with their images
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final response = await supabaseService
          .from('products')
          .select(
            'id, created_at, name, description, price, category, image(image_url, position)',
          )
          .order('id', ascending: true);

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
    String category,
  ) async {
    try {
      final response = await supabaseService
          .from('products')
          .select()
          .eq('category', category);
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
        Failure('Failed to fetch products by category: ${e.toString()}'),
      );
    } catch (e) {
      return Left(
        Failure('Failed to fetch products by category: ${e.toString()}'),
      );
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
