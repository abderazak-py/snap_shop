import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/constants.dart';
import 'package:snap_shop/core/utils/styles.dart';
import 'package:snap_shop/features/payment/domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = order.createdAt.toLocal();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kSecondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(15),

        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order N°${order.id}',
                  style: Styles.titleText20.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Spacer(),
                Text(
                  'Date: ${date.day}/${date.month}/${date.year}',
                  style: Styles.titleText14.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.kTextColor2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Products:',
                  style: Styles.titleText18.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                for (var item in order.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        if (item == order.items.first) Divider(),
                        Row(
                          children: [
                            Text(
                              'Name: ${item.productName}',
                              style: Styles.titleText14.copyWith(
                                fontWeight: FontWeight.w900,
                                //color: AppColors.kTextColor2,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'N°${item.productId}',
                              style: Styles.titleText14.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.kTextColor2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Price: ${item.productPrice} - Quantity: ${item.quantity}',
                              style: Styles.titleText14.copyWith(
                                fontWeight: FontWeight.w900,
                                color: AppColors.kTextColor2,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Subtotal: ${item.productPrice * item.quantity}',
                              style: Styles.titleText14.copyWith(
                                fontWeight: FontWeight.w900,
                                //color: AppColors.kTextColor2,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Total: ${order.total}',
              style: Styles.titleText22.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
