import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'core/utils/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const SnapShop());
  //TODO: make loadings good in all screens
  //TODO: add forgot password
  //TODO: make errors better
  //TODO: make the response cached
  //TODO make all future builders to bloc
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
