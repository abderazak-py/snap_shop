import 'package:flutter/material.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'core/utils/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const SnapShop());
}

//TODO handle exceptions with EITHER and add Failure class
//TODO add this to sign in with google: user?.name?.split(' ').first ?? 'Snapper'

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
