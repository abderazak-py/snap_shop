import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/injection_container.dart';
import '../../../../core/utils/styles.dart';
import '../cubit/orders_cubit.dart';
import 'widgets/order_card.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<OrdersCubit>()..getOrders(),
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersSuccess) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Column(
                    children: [
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 15),
                          child: Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: Text(
                              'Orders',
                              style: Styles.titleText30.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      OrderCard(order: order),
                      if (index != state.orders.length - 1)
                        const Divider(endIndent: 15, indent: 15),
                    ],
                  );
                },
              );
            } else if (state is OrdersFailure) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
