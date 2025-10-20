import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/product/data/models/product_model.dart';

class ProductRemoteDataSource {
  final ISupabaseService supabaseService;

  ProductRemoteDataSource(this.supabaseService);

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

  // Fetch a single product by ID
  Future<ProductModel?> getProductById(int productId) async {
    try {
      final response = await supabaseService
          .from('products')
          .select()
          .eq('id', productId)
          .single();
      return ProductModel.fromMap(response);
    } catch (e) {
      throw Exception('Failed to fetch product: ${e.toString()}');
    }
  }

  // Fetch products by category
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await supabaseService
          .from('products')
          .select()
          .eq('category', category);
      return (response as List)
          .map((product) => ProductModel.fromMap(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products by category: ${e.toString()}');
    }
  }

  // Add a new product (admin feature)
  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      final response = await supabaseService
          .from('products')
          .insert(product.toMap())
          .select()
          .single();
      return ProductModel.fromMap(response);
    } catch (e) {
      throw Exception('Failed to add product: ${e.toString()}');
    }
  }

  // Update an existing product (admin feature)
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response = await supabaseService
          .from('products')
          .update(product.toMap())
          .eq('id', product.id)
          .select()
          .single();
      return ProductModel.fromMap(response);
    } catch (e) {
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  // Delete a product (admin feature)
  Future<void> deleteProduct(int productId) async {
    try {
      await supabaseService.from('products').delete().eq('id', productId);
    } catch (e) {
      throw Exception('Failed to delete product: ${e.toString()}');
    }
  }
}
