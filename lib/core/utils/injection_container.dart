import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snap_shop/core/utils/private.dart';
import 'package:snap_shop/core/utils/supabase_service.dart';
import 'package:snap_shop/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:snap_shop/features/auth/data/repos/auth_repo_impl.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/is_user_signed_in_usecase.dart';
import 'package:snap_shop/features/auth/domain/usecases/login_usecases.dart';
import 'package:snap_shop/features/auth/domain/usecases/resend_otp_usecase.dart';
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
import 'package:snap_shop/features/chat/data/datasource/local_data_source.dart';
import 'package:snap_shop/features/chat/data/datasource/remote_data_source.dart';
import 'package:snap_shop/features/chat/data/repo/chat_repo.dart';
import 'package:snap_shop/features/chat/domain/repo/chat_repo_impl.dart';
import 'package:snap_shop/features/chat/domain/usecases/load_messages_usecase.dart';
import 'package:snap_shop/features/chat/domain/usecases/save_messages_usecase.dart';
import 'package:snap_shop/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:snap_shop/features/favorite/data/datasources/favorite_remote_data_source.dart';
import 'package:snap_shop/features/favorite/data/repos/favorite_repo_impl.dart';
import 'package:snap_shop/features/favorite/domain/repos/favorite_repo.dart';
import 'package:snap_shop/features/favorite/domain/usecases/toggle_favorite_usecase.dart';
import 'package:snap_shop/features/favorite/domain/usecases/get_favorite_items_usecase.dart';
import 'package:snap_shop/features/favorite/domain/usecases/remove_from_favorite_usecase.dart';
import 'package:snap_shop/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:snap_shop/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:snap_shop/features/notifications/data/repos/notification_repo_impl.dart';
import 'package:snap_shop/features/notifications/domain/repos/notification_repo.dart';
import 'package:snap_shop/features/notifications/domain/usecases/delete_notification_usecase.dart';
import 'package:snap_shop/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:snap_shop/features/notifications/domain/usecases/send_notification_usecase.dart';
import 'package:snap_shop/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:snap_shop/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:snap_shop/features/payment/data/repos/payment_repo_impl.dart';
import 'package:snap_shop/features/payment/domain/repos/payment_repo.dart';
import 'package:snap_shop/features/payment/domain/usecases/get_orders_usecase.dart';
import 'package:snap_shop/features/payment/domain/usecases/paypal_transactions_usecase.dart';
import 'package:snap_shop/features/payment/domain/usecases/save_order_usecase.dart';
import 'package:snap_shop/features/payment/presentation/cubit/orders_cubit.dart';
import 'package:snap_shop/features/product/data/datasources/product_remote_data_source.dart';
import 'package:snap_shop/features/product/data/repos/product_repository_impl.dart';
import 'package:snap_shop/features/product/domain/repos/product_repo.dart';
import 'package:snap_shop/features/product/domain/usecases/get_banners_usecase.dart';
import 'package:snap_shop/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_by_category_usecase.dart';
import 'package:snap_shop/features/product/domain/usecases/get_products_usecase.dart';
import 'package:snap_shop/features/product/presentation/cubit/banner/banner_cubit.dart';
import 'package:snap_shop/features/product/presentation/cubit/category/category_cubit.dart';
import 'package:snap_shop/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:snap_shop/features/search/data/datasources/search_remote_data_source.dart';
import 'package:snap_shop/features/search/data/repos/search_repo_impl.dart';
import 'package:snap_shop/features/search/domain/repos/search_repo.dart';
import 'package:snap_shop/features/search/domain/usecases/search_usecase.dart';
import 'package:snap_shop/features/search/domain/usecases/search_with_filters_usecase.dart';
import 'package:snap_shop/features/search/presentation/cubit/search_cubit.dart';
import 'package:snap_shop/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:snap_shop/features/settings/data/repos/settings_repo_impl.dart';
import 'package:snap_shop/features/settings/domain/repos/settings_repo.dart';
import 'package:snap_shop/features/settings/domain/usecases/change_avatar_usecase.dart';
import 'package:snap_shop/features/settings/domain/usecases/change_email_usecase.dart';
import 'package:snap_shop/features/settings/domain/usecases/change_name_usecase.dart';
import 'package:snap_shop/features/settings/domain/usecases/change_password_usecase.dart';
import 'package:snap_shop/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize Supabase Core
  await Supabase.initialize(
    url: SupaBaseConstants.supabaseUrl,
    anonKey: SupaBaseConstants.supabaseAnonKey,
  );
  // ||=====================||CORE||=====================||
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  sl.registerLazySingleton<ISupabaseService>(
    () => SupabaseService(Supabase.instance.client),
  );

  await GetStorage.init();

  // ||=====================||FIREBASE FCM||=====================||

  await Firebase.initializeApp(
    name: DefaultFirebaseOptions.currentPlatform.projectId,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data.entries}');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    systemInstruction: Content.system('''
You are a store assistant for our shopping app. Your sole purpose is to help users browse products, check availability, explain prices, shipping, and returns, manage carts, place and track orders, apply coupons, and answer store policy questions.

Hard constraints:
- Only discuss this store, its products, categories, inventory, pricing, discounts, shipping, returns, payment, and order support.
- If a request is unrelated (general knowledge, coding, news, politics, personal advice, etc.), reply briefly: 
  "I can help with our store, products, and orders. What would you like to buy or track?"
- Do not provide medical, legal, financial, or sensitive advice. Do not output personal data.
- Keep answers concise, friendly, and action-oriented (offer next steps like: view category, add to cart, track order, contact support).

When needed, ask at most one clarifying question specific to shopping (e.g., size, color, budget).
    '''),
  );
  sl.registerLazySingleton<FirebaseProvider>(
    () => FirebaseProvider(model: model),
  );
  sl.registerLazySingleton<GetStorage>(() => GetStorage());

  final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);

  final userId = sl<ISupabaseService>().auth.currentUser?.id;

  if (userId != null) {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await Supabase.instance.client
          .from('profiles')
          .update({'fcm_token': token})
          .eq('id', userId);
    }
  }

  if ((notificationSettings.authorizationStatus ==
              AuthorizationStatus.authorized ||
          notificationSettings.authorizationStatus ==
              AuthorizationStatus.provisional) &&
      userId != null) {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      sl<ISupabaseService>()
          .from('profiles')
          .update({'fcm_token': fcmToken})
          .eq('user_id', sl<ISupabaseService>().auth.currentUser!.id);
    });
  }

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
  sl.registerLazySingleton<ResendOtpUsecase>(
    () => ResendOtpUsecase(sl<AuthRepository>()),
  );
  // Cubit/Bloc
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      signInWithGoogleNativeUseCase: sl<SignInWithGoogleNativeUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
      verifyOtpUseCase: sl<VerifyOtpUsecase>(),
      resendOtpUsecase: sl<ResendOtpUsecase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  // ||=====================||CHAT||=====================||

  // Data Sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSource(sl<FirebaseProvider>()),
  );
  sl.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSource(sl<GetStorage>()),
  );

  // Repositories
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      sl<ChatRemoteDataSource>(),
      sl<ChatLocalDataSource>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<SaveMessagesUsecase>(
    () => SaveMessagesUsecase(sl<ChatRepository>()),
  );
  sl.registerLazySingleton<LoadMessagesUsecase>(
    () => LoadMessagesUsecase(sl<ChatRepository>()),
  );
  sl.registerLazySingleton<SendMessageUsecase>(
    () => SendMessageUsecase(sl<ChatRepository>()),
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
  sl.registerLazySingleton<GetBannersUseCase>(
    () => GetBannersUseCase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<GetCategoriesUsecase>(
    () => GetCategoriesUsecase(sl<ProductRepository>()),
  );
  sl.registerLazySingleton<GetProductsByCategoryUsecase>(
    () => GetProductsByCategoryUsecase(sl<ProductRepository>()),
  );

  // Cubit/Bloc
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(
      getProductsUseCase: sl<GetProductsUseCase>(),
      getProductsByCategoryUsecase: sl<GetProductsByCategoryUsecase>(),
    ),
  );
  sl.registerFactory<BannerCubit>(
    () => BannerCubit(getBannersUseCase: sl<GetBannersUseCase>()),
  );
  sl.registerFactory<CategoryCubit>(
    () => CategoryCubit(getCategoriesUsecase: sl<GetCategoriesUsecase>()),
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

  // Cubit/Bloc
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

  // Cubit/Bloc
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
  sl.registerLazySingleton<GetOrdersUsecase>(
    () => GetOrdersUsecase(sl<PaymentRepository>()),
  );

  // Cubit/Bloc
  sl.registerFactory<OrdersCubit>(
    () => OrdersCubit(getOrdersUsecase: sl<GetOrdersUsecase>()),
  );

  // ||=====================||NOTIFICATIONS||=====================||

  // Data Sources
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSource(sl<ISupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationRepositoryImpl(sl<NotificationsRemoteDataSource>()),
  );

  // Use Cases
  sl.registerLazySingleton<GetNotificationsUsecase>(
    () => GetNotificationsUsecase(sl<NotificationsRepository>()),
  );
  sl.registerLazySingleton<SendNotificationUsecase>(
    () => SendNotificationUsecase(sl<NotificationsRepository>()),
  );
  sl.registerLazySingleton<DeleteNotificationUsecase>(
    () => DeleteNotificationUsecase(sl<NotificationsRepository>()),
  );

  // Cubit/Bloc
  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(
      getNotificationsUsecase: sl<GetNotificationsUsecase>(),
      deleteNotificationUsecase: sl<DeleteNotificationUsecase>(),
    ),
  );

  // ||=====================||SETTINGS||=====================||

  // Data Sources
  sl.registerLazySingleton<SettingsRemoteDatasource>(
    () => SettingsRemoteDatasource(sl<SupabaseService>()),
  );

  // Repositories
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl<SettingsRemoteDatasource>()),
  );

  // Use Cases
  sl.registerLazySingleton<ChangeNameUsecase>(
    () => ChangeNameUsecase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<ChangeEmailUsecase>(
    () => ChangeEmailUsecase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(sl<SettingsRepository>()),
  );
  sl.registerLazySingleton<ChangeAvatarUsecase>(
    () => ChangeAvatarUsecase(sl<SettingsRepository>()),
  );
}
