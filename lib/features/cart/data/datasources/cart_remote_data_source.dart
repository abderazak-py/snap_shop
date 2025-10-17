import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/cart/data/models/cart_model.dart';

class CartRemoteDataSource {
  final ISupabaseService supabaseService;

  CartRemoteDataSource(this.supabaseService);

  Future<Either<Failure, void>> addOneToCart(int productId) async {
    try {
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
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

  Future<Either<Failure, void>> removeOneFromCart(int productId) async {
    try {
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }
      final result = await supabaseService
          .from('cart')
          .select()
          .eq('product_id', productId)
          .eq('user_id', supabaseService.auth.currentUser!.id);

      if (result.isNotEmpty) {
        // Product already in cart, update quantity
        final currentQuantity = result[0]['quantity'] as int;
        final cartId = result[0]['id'];
        if (currentQuantity <= 1) {
          await supabaseService.from('cart').delete().eq('id', cartId);
        } else {
          await supabaseService
              .from('cart')
              .update({'quantity': result[0]['quantity'] - 1})
              .eq('id', result[0]['id']);
        }
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
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }

      final response = await supabaseService
          .from('cart')
          .select(
            'id, quantity, user_id, added_at, product_id, products(name, price, image!inner(image_url, position))',
          )
          .eq('user_id', supabaseService.auth.currentUser!.id)
          .eq('products.image.position', 1);

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
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }
      await supabaseService
          .from('cart')
          .delete()
          .eq('user_id', supabaseService.auth.currentUser!.id);
    } catch (e) {
      return Left(Failure('Failed to empty cart: ${e.toString()}'));
    }
    return const Right(null);
  }
}
