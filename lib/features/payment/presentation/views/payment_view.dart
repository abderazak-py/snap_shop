import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/private.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../cart/domain/usecases/empty_cart_usecase.dart';
import '../../domain/usecases/save_order_usecase.dart';
import '../cubit/transactions_cubit.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key, required this.addressId});
  final int addressId;

  @override
  Widget build(BuildContext context) {
    final emptyCartUsecase = sl<EmptyCartUsecase>();
    final saveOrderUsecase = sl<SaveOrderUsecase>();

    return BlocProvider(
      create: (context) => sl<TransactionsCubit>(),
      child: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          if (state is TransactionsSuccess) {
            return PaypalCheckoutView(
              sandboxMode: true,
              note: "Thank you for your order!",
              onSuccess: (Map params) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Payment Successful')),
                );
                await saveOrderUsecase.execute(addressId: addressId);
                emptyCartUsecase.execute();
                if (!context.mounted) return;
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
                        content: const Text(
                          'Your order will be delivered soon.',
                        ),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('❌ Payment Error')),
                );
                GoRouter.of(context).pop();
              },
              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('⚠️ Payment Canceled')),
                );
                GoRouter.of(context).pop();
              },
              transactions: state.transactions,
              clientId: PaypalConstants.paypalClientId,
              secretKey: PaypalConstants.paypalSecret,
            );
          } else if (state is TransactionsFailure) {
            return Scaffold(body: CustomErrorWidget(errorMsg: state.error));
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
