import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/cart/data/models/cart_model.dart';

class CartRemoteDataSource {
  final ISupabaseService supabaseService;

  CartRemoteDataSource(this.supabaseService);

  Future<Either<Failure, void>> addToCart(int productId) async {
    try {
      if (supabaseService.auth.currentUser == null) {
        throw Exception('User not logged in');
      }
      final result = await supabaseService
          .from('cart')
          .select()
          .eq('product_id', productId)
          .eq('user_id', supabaseService.auth.currentUser!.id);

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
      return Left(Failure('Failed to add to cart: ${e.toString()}'));
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> removeFromCart(int id) async {
    try {
      await supabaseService.from('cart').delete().eq('id', id);
    } catch (e) {
      return Left(Failure('Failed to remove from cart: ${e.toString()}'));
    }
    return const Right(null);
  }

  Future<Either<Failure, List<CartModel>>> getCartItems() async {
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
      final result = (response as List)
          .map((cart) => CartModel.fromMap(cart))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to get cart items: ${e.toString()}'));
    }
  }

  Future<Either<Failure, void>> emptyCart() async {
    try {
      String? userId = supabaseService.auth.currentUser?.id;
      if (userId == null) {
        return Left(Failure('User not logged in'));
      }
      await supabaseService.from('cart').delete().eq('user_id', userId);
    } catch (e) {
      return Left(Failure('Failed to empty cart: ${e.toString()}'));
    }
    return const Right(null);
  }
}
