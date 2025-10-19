import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'core/utils/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const SnapShop());
}

//TODO handle exceptions with EITHER and add Failure class

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
