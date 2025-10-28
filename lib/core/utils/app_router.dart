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
import 'package:snap_shop/features/payment/presentation/views/orders_view.dart';
import 'package:snap_shop/features/payment/presentation/views/payment_view.dart';
import 'package:snap_shop/features/product/domain/entities/category_entity.dart';
import 'package:snap_shop/features/product/domain/entities/product_entity.dart';
import 'package:snap_shop/features/product/presentation/views/category_view.dart';
import 'package:snap_shop/features/product/presentation/views/product_details_view.dart';
import 'package:snap_shop/features/product/presentation/views/product_view.dart';
import 'package:snap_shop/features/search/presentation/views/search_products_view.dart';
import 'package:snap_shop/features/settings/presentation/views/settings_view.dart';
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
  static const kSettingsView = '/settings';
  static const kOrdersView = '/orders';
  static const kCategoryView = '/category';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kAuthView, builder: (context, state) => const AuthView()),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: kConfirmOtpView,
        builder: (context, state) =>
            ConfirmOtpView(email: state.extra as String),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(path: kCartView, builder: (context, state) => const CartView()),
      GoRoute(
        path: kProductView,
        builder: (context, state) => const ProductView(),
      ),
      GoRoute(
        path: kProductDetailsView,
        builder: (context, state) =>
            ProductDetailsView(product: state.extra as ProductEntity),
      ),
      GoRoute(
        path: kSearchProductsView,
        builder: (context, state) => BlocProvider.value(
          value: sl<FavoriteCubit>(),
          child: const SearchProductsView(),
        ),
      ),
      GoRoute(
        path: kPaymentView,
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(
        path: kOrdersView,
        builder: (context, state) => const OrdersView(),
      ),
      GoRoute(
        path: kSettingsView,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: kCategoryView,
        builder: (context, state) =>
            CategoryView(category: state.extra as CategoryEntity),
      ),
    ],
  );
}
