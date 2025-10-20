import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/presentation/views/auth_view.dart';
import 'package:snap_shop/features/auth/presentation/views/confirm_otp_view.dart';
import 'package:snap_shop/features/auth/presentation/views/login_view.dart';
import 'package:snap_shop/features/auth/presentation/views/register_view.dart';
import 'package:snap_shop/features/cart/presentation/views/cart_view.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/home/presentation/views/home_view.dart';
import 'package:snap_shop/features/payment/presentation/views/payment_view.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/views/product_details_view.dart';
import 'package:snap_shop/features/product/presentation/views/product_view.dart';
import 'package:snap_shop/features/search/presentation/views/search_products_view.dart';
import 'package:snap_shop/features/splach/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kAuthView = '/auth_view';
  static const kHomeView = '/home';
  static const kProductView = '/product';
  static const kLoginView = '/login';
  static const kRegisterView = '/register';
  static const kCartView = '/cart';
  static const kProductDetailsView = '/product_details';
  static const kSearchProductsView = '/search_products';
  static const kConfirmOtpView = '/confirm_otp';
  static const kPaymentView = '/payment';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/auth_view',
        builder: (context, state) => const AuthView(),
      ),
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
      GoRoute(path: '/home', builder: (context, state) => const HomeView()),
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
        builder: (context, state) => BlocProvider.value(
          value: sl<FavoriteCubit>(),
          child: const SearchProductsView(),
        ),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentView(),
      ),
    ],
  );
}
