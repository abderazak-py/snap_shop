import 'package:get_it/get_it.dart';
import 'package:snap_shop/core/utils/private.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:snap_shop/features/auth/data/repos/auth_repo_impl.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/is_user_signed_in_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/login_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/sign_in_with_google_native_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/register_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:snap_shop/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:snap_shop/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:snap_shop/features/cart/data/repos/cart_repo_impl.dart';
import 'package:snap_shop/features/cart/domain/repos/cart_repo.dart';
import 'package:snap_shop/features/cart/domain/usecases/add_one_to_cart_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/empty_cart_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:snap_shop/features/cart/domain/usecases/remove_one_from_cart_usecase.dart';
import 'package:snap_shop/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:snap_shop/features/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:snap_shop/features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:snap_shop/features/favorite/domain/repos/favorite_repo.dart';
import 'package:snap_shop/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:snap_shop/features/favorite/domain/usecases/get_favorite_items_usecase.dart';
import 'package:snap_shop/features/favorite/domain/usecases/remove_from_favorite_usecase.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:snap_shop/features/payment/data/repos/payment_repo_impl.dart';
import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';
import 'package:snap_shop/features/payment/domain/usecases/paypal_transactions_usecase.dart';
import 'package:snap_shop/features/payment/domain/usecases/save_order_usecase.dart';
import 'package:snap_shop/features/product/data/datasources/product_remote_data_source.dart';
import 'package:snap_shop/features/product/data/repos/product_repository_impl.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';
import 'package:snap_shop/features/product/presentation/cubit/product_cubit.dart';
import 'package:snap_shop/features/search/data/datasources/search_remote_data_source.dart';
import 'package:snap_shop/features/search/data/repos/search_repo_impl.dart';
import 'package:snap_shop/features/search/domain/repos/search_repo.dart';
import 'package:snap_shop/features/search/domain/usecases/search_usecase.dart';
import 'package:snap_shop/features/search/domain/usecases/search_with_filters_usecase.dart';
import 'package:snap_shop/features/search/presentation/cubit/search_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Supabase Core
  await Supabase.initialize(
    url: SupaBaseConstants.supabaseUrl,
    anonKey: SupaBaseConstants.supabaseAnonKey,
  );

  // ||=====================||CORE||=====================||

  sl.registerLazySingleton<ISupabaseService>(
    () => SupabaseService(Supabase.instance.client),
  );

  // ||=====================||AUTH||=====================||

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<ISupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignInWithGoogleNativeUseCase>(
    () => SignInWithGoogleNativeUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<IsUserSignedInUsecase>(
    () => IsUserSignedInUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<VerifyOtpUsecase>(
    () => VerifyOtpUsecase(sl<AuthRepository>()),
  );
  // Cubit/Bloc
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      signInWithGoogleNativeUseCase: sl<SignInWithGoogleNativeUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUsecase>(),
    ),
  );

  // ||=====================||PRODUCTS||=====================||

  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl<ISupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(sl<ProductRepository>()),
  );

  // Cubit/Bloc
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(getProductsUseCase: sl<GetProductsUseCase>()),
  );

  // ||=====================||PRODUCTS||=====================||

  // Data Sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSource(sl<ISupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl<SearchRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(sl<SearchRepository>()),
  );
  sl.registerLazySingleton<SearchWithFiltersUsecase>(
    () => SearchWithFiltersUsecase(sl<SearchRepository>()),
  );

  // Cubit/Bloc
  sl.registerFactory<SearchCubit>(
    () => SearchCubit(
      searchUsecase: sl<SearchUsecase>(),
      searchWithFiltersUsecase: sl<SearchWithFiltersUsecase>(),
    ),
  );

  // ||=====================||CART||=====================||

  // Data Sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSource(sl<ISupabaseService>()),
  );
  // Repositories
  sl.registerLazySingleton<CartRepository>(
    () => CartRepoImpl(sl<CartRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<GetCartItemsUsecase>(
    () => GetCartItemsUsecase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<AddOneToCartUsecase>(
    () => AddOneToCartUsecase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<RemoveOneFromCartUsecase>(
    () => RemoveOneFromCartUsecase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<RemoveFromCartUsecase>(
    () => RemoveFromCartUsecase(sl<CartRepository>()),
  );
  sl.registerLazySingleton<EmptyCartUsecase>(
    () => EmptyCartUsecase(sl<CartRepository>()),
  );
  sl.registerFactory<CartCubit>(
    () => CartCubit(
      getCartItemsUsecase: sl<GetCartItemsUsecase>(),
      addOneToCartUsecase: sl<AddOneToCartUsecase>(),
      removeOneFromCartUsecase: sl<RemoveOneFromCartUsecase>(),
    ),
  );

  // ||=====================||FAVORITE||=====================||

  // Data Sources
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSource(sl<ISupabaseService>()),
  );
  // Repositories
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepoImpl(sl<FavoriteRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<GetFavoriteItemsUsecase>(
    () => GetFavoriteItemsUsecase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton<ToggleFavoriteeUsecase>(
    () => ToggleFavoriteeUsecase(sl<FavoriteRepository>()),
  );

  sl.registerLazySingleton<RemoveFromFavoriteUsecase>(
    () => RemoveFromFavoriteUsecase(sl<FavoriteRepository>()),
  );

  sl.registerLazySingleton<FavoriteCubit>(
    () => FavoriteCubit(
      addToFavoriteUsecase: sl<ToggleFavoriteeUsecase>(),
      getFavoriteItemsUsecase: sl<GetFavoriteItemsUsecase>(),
    ),
  );

  // ||=====================||PAYMENT||=====================||

  // Data Sources
  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSource(sl<ISupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl<PaymentRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<PaypalTransactionsUsecase>(
    () => PaypalTransactionsUsecase(sl<PaymentRepository>()),
  );
  sl.registerLazySingleton<SaveOrderUsecase>(
    () => SaveOrderUsecase(sl<PaymentRepository>()),
  );
}
