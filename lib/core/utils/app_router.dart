import 'package:go_router/go_router.dart';
import 'package:snap_shop/features/auth/presentation/confirm_otp_view.dart';
import 'package:snap_shop/features/auth/presentation/login_view.dart';
import 'package:snap_shop/features/auth/presentation/register_view.dart';
import 'package:snap_shop/features/cart/presentation/cart_view.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/product_details_view.dart';
import 'package:snap_shop/features/product/presentation/product_view.dart';
import 'package:snap_shop/features/product/presentation/search_products_view.dart';
import 'package:snap_shop/features/splach/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kProductView = '/product';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kCartView = '/cart';
  static const kProductDetailsView = '/product_details';
  static const kSearchProductsView = '/search_products';
  static const kConfirmOtpView = '/confirm_otp';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/confirm_otp',
        builder: (context, state) =>
            ConfirmOtpView(email: state.extra as String),
      ),
      GoRoute(path: '/cart', builder: (context, state) => const CartView()),
      GoRoute(
        path: '/product',
        builder: (context, state) => const ProductView(),
      ),
      GoRoute(
        path: '/product_details',
        builder: (context, state) =>
            ProductDetailsView(product: state.extra as ProductEntity),
      ),
      GoRoute(
        path: '/search_products',
        builder: (context, state) => const SearchProductsView(),
      ),
    ],
  );
}
