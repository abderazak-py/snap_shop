import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';

class PaymentRemoteDataSource {
  final ISupabaseService supabaseService;
  PaymentRemoteDataSource(this.supabaseService);
  final getCartItemsUsecase = sl<GetCartItemsUsecase>();
  Future<List<Map<String, dynamic>>> paypalTransactions() async {
    final cartItems = await getCartItemsUsecase.execute();
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

      final cartItems = await getCartItemsUsecase.execute();
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
            'shipping_discount': shippingDiscount,
          })
          .select()
          .single();

      final orderId = orderResponse['id'];

      // Map and insert order items with the order_id
      final orderItems = cartItems.map((item) {
        return {
          'order_id': orderId,
          'product_id': item.productId,
          'quantity': item.quantity,
        };
      }).toList();

      await supabaseService.from('order_items').insert(orderItems);
    } catch (e) {
      throw Exception('Failed to save order: ${e.toString()}');
    }
  }
}
