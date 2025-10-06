import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/app_router.dart';

void main() async {
  runApp(const SnapShop());
}

class SnapShop extends StatelessWidget {
  const SnapShop({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
