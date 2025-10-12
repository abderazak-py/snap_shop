import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/cart/data/models/cart_model.dart';

class CartRemoteDataSource {
  final ISupabaseService supabaseService;

  CartRemoteDataSource(this.supabaseService);

  Future<void> addToCart(int productId) async {
    try {
      if (supabaseService.auth.currentUser == null) {
        throw Exception('User not logged in');
      }
      final result = await supabaseService
          .from('cart')
          .select()
          .eq('product_id', productId)
          .eq('user_id', supabaseService.auth.currentUser!);

      if (result.isNotEmpty) {
        // Product already in cart, update quantity
        await supabaseService
            .from('cart')
            .update({'quantity': result[0]['quantity'] + 1})
            .eq('id', result[0]['id']);
      } else {
        await supabaseService.from('cart').insert({
          'product_id': productId,
          'user_id': supabaseService.auth.currentUser?.id,
          'quantity': 1,
        });
      }
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await supabaseService.from('cart').delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to remove from cart: ${e.toString()}');
    }
  }

  Future<List<CartModel>> getCartItems() async {
    try {
      String? userId = supabaseService.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      final response = await supabaseService
          .from('cart')
          .select(
            'id, quantity, user_id, added_at, product_id, products(name, price)',
          )
          .eq('user_id', userId);
      return (response as List).map((cart) => CartModel.fromMap(cart)).toList();
    } catch (e) {
      throw Exception('Failed to get cart items: ${e.toString()}');
    }
  }

  Future<void> emptyCart() async {
    try {
      String? userId = supabaseService.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not logged in');
      }
      await supabaseService.from('cart').delete().eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to empty cart: ${e.toString()}');
    }
  }
}
