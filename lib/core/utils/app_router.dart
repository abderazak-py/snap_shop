import 'package:go_router/go_router.dart';
import 'package:snap_shop/features/product/presentation/product_view.dart';
import 'package:snap_shop/features/splach/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kProductView = '/product';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/product',
        builder: (context, state) => const ProductView(),
      ),
    ],
  );
}
