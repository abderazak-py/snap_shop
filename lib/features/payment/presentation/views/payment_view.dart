import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/core/utils/private.dart';
import 'package:snap_shop/features/cart/domain/usecases/empty_cart_usecase.dart';
import 'package:snap_shop/features/payment/domain/usecases/paypal_transactions_usecase.dart';
import 'package:snap_shop/features/payment/domain/usecases/save_order_usecase.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final paypalTransactionsUsecase = sl<PaypalTransactionsUsecase>();
    final emptyCartUsecase = sl<EmptyCartUsecase>();
    final saveOrderUsecase = sl<SaveOrderUsecase>();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: paypalTransactionsUsecase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Failed to load cart items for payment')),
          );
        }

        final transactions = snapshot.data!;

        return PaypalCheckoutView(
          sandboxMode: true,
          note: "Thank you for your order!",
          onSuccess: (Map params) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Payment Successful')),
            );
            emptyCartUsecase.execute();
            saveOrderUsecase.execute(transactions: transactions);
            GoRouter.of(context).go(AppRouter.kHomeView);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final ctx = GoRouter.of(context)
                  .routerDelegate
                  .navigatorKey
                  .currentContext; // ensure Home context
              if (ctx != null) {
                showDialog(
                  context: ctx,
                  builder: (_) => AlertDialog(
                    title: const Text('Thank you'),
                    content: const Text('Your order will be delivered soon.'),
                    actions: [
                      TextButton(
                        onPressed: () => GoRouter.of(ctx).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            });
          },
          onError: (error) {
            debugPrint(error.toString());
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('❌ Payment Error')));
            GoRouter.of(context).pop();
          },
          onCancel: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('⚠️ Payment Canceled')),
            );
            GoRouter.of(context).pop();
          },
          transactions: transactions,
          clientId: PaypalConstants.paypalClientId,
          secretKey: PaypalConstants.paypalSecret,
        );
      },
    );
  }
}
