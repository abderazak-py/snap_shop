import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/supabase_service.dart';
import '../models/favorite_model.dart';

class FavoriteRemoteDataSource {
  final ISupabaseService supabaseService;

  FavoriteRemoteDataSource(this.supabaseService);

  Future<Either<Failure, void>> toggleFavorite(int productId) async {
    try {
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }
      final userId = supabaseService.auth.currentUser!.id;
      final existing = await supabaseService
          .from('favorite')
          .select('id')
          .eq('user_id', userId)
          .eq('product_id', productId)
          .maybeSingle();
      if (existing != null) {
        await supabaseService
            .from('favorite')
            .delete()
            .eq('id', existing['id']);
      } else {
        await supabaseService.from('favorite').insert({
          'product_id': productId,
          'user_id': supabaseService.auth.currentUser?.id,
        });
      }
    } catch (e) {
      return Left(Failure('Failed to add to favorite: ${e.toString()}'));
    }
    return const Right(null);
  }

  Future<Either<Failure, void>> removeFromFavorite(int id) async {
    try {
      await supabaseService.from('favorite').delete().eq('id', id);
    } catch (e) {
      return Left(Failure('Failed to remove from favorite: ${e.toString()}'));
    }
    return const Right(null);
  }

  Future<Either<Failure, List<FavoriteModel>>> getFavoriteItems() async {
    try {
      if (supabaseService.auth.currentUser == null) {
        Left(Failure('User not logged in'));
      }

      final response = await supabaseService
          .from('favorite')
          .select(
            'id, user_id, added_at, product_id, products(name, price, image!inner(image_url, position))',
          )
          .eq('user_id', supabaseService.auth.currentUser!.id)
          .eq('products.image.position', 1);

      final result = (response as List)
          .map((favorite) => FavoriteModel.fromMap(favorite))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to get favorite items: ${e.toString()}'));
    }
  }
}
