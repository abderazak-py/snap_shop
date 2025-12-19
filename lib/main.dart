import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'core/utils/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const SnapShop());
  //TODO: add forgot password
  //TODO: optimize and complete add address
  //TODO: add address in order

  // {
  //    notes before production
  //   -- add error hanling everywhere and loading indicators
  //   -- test on real devices
  //   -- add error handling everywhere and loading indicators
  //   -- optimize images and assets
  //   -- review security rules for database and storage
  //   -- final testing for all features
  // }
}

class SnapShop extends StatelessWidget {
  const SnapShop({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
