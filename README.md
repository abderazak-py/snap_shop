# Snap Shop

A modern e-commerce mobile application built with Flutter, featuring a clean architecture pattern and integrated with Supabase backend services.

## Screenshots

| Splach | Landing | Login |
| :-----------: | :---------: | :----------: |
| ![screenshots/splach.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/splach.webp) | ![screenshots/auth-home.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/auth-home.webp) | ![screenshots/login.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/login.webp) |
| **Register** | **Home** | **Catalog** |   |
| ![screenshots/register.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/register.webp) | ![screenshots/home.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/home.webp) | ![screenshots/catalog.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/catalog.webp) |   |
| **Favorite** | **Profile** | **Search** |   |
| ![screenshots/favorite.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/favorite.webp) | ![screenshots/profile.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/profile.webp) | ![screenshots/search-filters.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search-filters.webp) |   |
| **Cart** | **Orders** | **Settings** |   |
| ![screenshots/cart-page.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/cart-page.webp) | ![screenshots/orders.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/orders.webp) | ![screenshots/settings.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/settings.webp) |   |
| **Loading** | **Popup** | **Search** |   |
| ![screenshots/search-loading.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search-loading.webp) | ![screenshots/logout-popup.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/logout-popup.webp) | ![screenshots/search.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search.webp) |   |
| **Payment** | **Product** | **Notifications** |   |
| ![screenshots/payment.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/payment.webp) | ![screenshots/product-page.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/product-page.webp) | ![screenshots/notifications.webp](https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/notifications.webp) |   |

## 📱 Features

- **User Authentication**
  - Email/password registration and login
  - OTP verification process
  - Google Sign-In integration
- **Product Catalog**
  - Browse products by categories
  - Product search functionality
  - Detailed product views
- **Shopping Cart**
  - Add/remove items
  - Adjust quantities
  - Real-time cart updates
- **Favorites System**
  - Save favorite products
  - Quick access to liked items
- **Payment Processing**
  - Integrated PayPal payments
  - Order history tracking
- **Notifications**
  - In-app notification center
  - Order completion alerts
  - User-specific notifications
- **User Profile**
  - Personal information management
  - Avatar upload capability (soon)
  - Security settings (soon)

## 🏗️ Architecture

The project follows a Clean Architecture pattern with separation of concerns:

- **Core Layer**: Contains shared utilities, errors handling, routing, and dependency injection
- **Feature Modules**:
  - Auth: Authentication system
  - Cart: Shopping cart functionality
  - Favorite: Wishlist management
  - Home: Main dashboard
  - Notifications: In-app notifications system
  - Payment: Checkout and order processing
  - Product: Product catalog and details
  - Profile: User profile management
  - Search: Product search capabilities
  - Settings: Application preferences
  - Splash: Initial 

Each feature module is organized into:
```
feature/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repos/
├── domain/
│   ├── entities/
│   ├── repos/
│   └── usecases/
└── presentation/
    ├── cubit/
    └── views/
```

## 🛠️ Technologies Used

- **Framework**: Flutter
- **State Management**: Bloc/Cubit pattern
- **Backend**: Supabase (Authentication, Database, Storage)
- **Routing**: go_router
- **Dependency Injection**: get_it
- **Payment**: PayPal integration
- **UI Components**:
  - Material Design
  - Custom SVG icons
  - Cached network images

## 📦 Key Dependencies

- `flutter_bloc`: State management
- `supabase_flutter`: Backend services integration
- `go_router`: Navigation and routing
- `dartz`: Functional programming utilities
- `equatable`: Value equality comparison
- `flutter_paypal_payment`: Payment processing
- `google_sign_in`: Google authentication
- `cached_network_image`: Image caching

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/abderazak-py/snap_shop
   cd snap_shop
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Supabase:
   - Create a Supabase project
   - Update the Supabase credentials in `lib/core/utils/supabase_service.dart`

4. Run the application:
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── errors/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── cart/
│   ├── favorite/
│   ├── home/
│   ├── notifications/
│   ├── payment/
│   ├── product/
│   ├── profile/
│   ├── search/
│   ├── settings/
│   └── splash/
└── main.dart
```

## 🔧 Configuration

Before running the app, you need to set up your environment variables:

1. Supabase configuration in `lib/core/utils/supabase_service.dart`
2. PayPal credentials for payment processing
3. Google Sign-In client IDs for OAuth

## 🎨 UI/UX Design

The app features a modern, responsive design with:
- Intuitive navigation
- Smooth animations and transitions
- Consistent styling system
- Adaptive layouts for different screen sizes
- Loading skeletons for better perceived performance

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## 📄 License

This project is proprietary and confidential. All rights reserved.

## 📞 Support

For support, contact the development team or open an issue in the repository.