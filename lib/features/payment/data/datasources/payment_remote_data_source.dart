import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:snap_shop/core/errors/failure.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:snap_shop/features/payment/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentRemoteDataSource {
  final ISupabaseService supabaseService;
  PaymentRemoteDataSource(this.supabaseService);
  final getCartItemsUsecase = sl<GetCartItemsUsecase>();
  Future<List<Map<String, dynamic>>> paypalTransactions() async {
    final res = await getCartItemsUsecase.execute();
    final cartItems = res.fold((l) => throw Exception(l.message), (r) => r);

    if (cartItems.isEmpty) {
      throw Exception('Cart is empty');
    }

    final items = cartItems.map((item) {
      return {
        "name": item.productName,
        "quantity": item.quantity,
        "price": item.productPrice.toString(),
        "currency": "USD",
      };
    }).toList();

    final subtotal = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + (item.productPrice * item.quantity),
    );
    final shipping = 0.0;
    final shippingDiscount = 0.0;
    final total = subtotal + shipping - shippingDiscount;

    return [
      {
        "amount": {
          "total": total,
          "currency": "USD",
          "details": {
            "subtotal": subtotal,
            "shipping": shipping,
            "shipping_discount": shippingDiscount,
          },
        },
        "description": "The payment transaction description.",
        "item_list": {"items": items},
      },
    ];
  }

  Future<void> saveOrder() async {
    try {
      if (supabaseService.auth.currentUser == null) {
        throw Exception('User not logged in');
      }
      final res = await getCartItemsUsecase.execute();
      final cartItems = res.fold((l) => throw Exception(l.message), (r) => r);
      if (cartItems.isEmpty) {
        throw Exception('Cart is empty');
      }
      final subtotal = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + (item.productPrice * item.quantity),
      );
      final shipping = 0.0;
      final shippingDiscount = 0.0;
      final total = subtotal + shipping - shippingDiscount;

      // Insert order and get new order ID
      final orderResponse = await supabaseService
          .from('orders')
          .insert({
            'user_id': supabaseService.auth.currentUser!.id,
            'total': total,
            'currency': 'USD',
            'shipping': shipping,
          })
          .select()
          .single();

      final orderId = orderResponse['id'];

      // Map and insert order items with the order_id
      final orderItems = cartItems.map((item) {
        return {
          'product_id': item.productId,
          'quantity': item.quantity,
          'order_id': orderId,
        };
      }).toList();

      await supabaseService.from('order_item').insert(orderItems);
    } catch (e) {
      throw Exception('Failed to save order: ${e.toString()}');
    }
  }

  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final user = supabaseService.auth.currentUser;
      if (user == null) {
        return Left(Failure('User not logged in'));
      }

      final data = await supabaseService
          .from('orders')
          .select('''
                    id,
                    user_id,
                    total,
                    currency,
                    shipping,
                    created_at,
                    order_item (id,order_id, product_id, quantity)''')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      final list = (data as List)
          .map<Map<String, dynamic>>((row) {
            final map = Map<String, dynamic>.from(row as Map);
            final nested = (map['order_item'] as List? ?? const [])
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList();
            map
              ..remove('order_item')
              ..['items'] = nested;
            return map;
          })
          .map(OrderModel.fromMap)
          .toList();

      return Right(list);
    } on SocketException {
      return Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on PostgrestException catch (e) {
      return Left(Failure('Failed to get orders: ${e.toString()}'));
    } catch (e) {
      return Left(Failure('Failed to fetch orders: ${e.toString()}'));
    }
  }
}
