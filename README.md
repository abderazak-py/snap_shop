# Snap Shop

A modern e-commerce mobile application built with Flutter, featuring a clean architecture pattern and integrated with Supabase backend services.

## Screenshots

| Splach | Landing | Login |
| :-----------: | :---------: | :----------: |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/splach.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/auth-home.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/login.webp" width="260"/> |
| **Register** | **Home** | **Catalog** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/register.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/home.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/catalog.webp" width="260"/> |
| **Favorite** | **Profile** | **Search** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/favorite.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/profile.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search-filters.webp" width="260"/> |
| **Cart** | **Orders** | **Settings** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/cart-page.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/orders.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/settings.webp" width="260"/> |
| **Loading** | **Popup** | **Search** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search-loading.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/logout-popup.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/search.webp" width="260"/> |
| **Payment** | **Product** | **Notifications** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/payment.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/product-page.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/notifications.webp" width="260"/> |
| **Ai Chat** | **Forgot Password** | **OTP** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/chat.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/forgot-password.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/otp.webp" width="260"/> |
| **Add Address** | **Addresses** | **Map** |
| <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/add-address.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/addresses.webp" width="260"/> | <img src="https://cdn.jsdelivr.net/gh/abderazak-py/snap_shop@main/screenshots/map.webp" width="260"/> |

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
- **AI Assistant**
  - Integrated Gemini AI chatbot for shopping assistance
  - Persistent chat history
  - Context-aware responses about products and orders
  - Smart shopping recommendations
- **Address Management** 
  - Add new addresses with GPS location selection or interactive map picker
  - Auto-fill address fields (street, city, postal code, country) from selected coordinates via geocoding
  - Manual editing of auto-filled fields for precision
  - View and manage multiple saved addresses
  - Set default shipping address for orders

## 🏗️ Architecture

The project follows a Clean Architecture pattern with separation of concerns:

- **Core Layer**: Contains shared utilities, errors handling, routing, and dependency injection
- **Feature Modules**:
  - Address: Address management with geocoding and map integration
  - Auth: Authentication system
  - Cart: Shopping cart functionality
  - Chat: AI assistant integration
  - Favorite: Wishlist management
  - Home: Main dashboard
  - Notifications: In-app notifications system
  - Payment: Checkout and order processing
  - Product: Product catalog and details
  - Profile: User profile management
  - Search: Product search capabilities
  - Settings: Application preferences
  - Splash: Initial app loading 

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
- **AI Assistant**: Firebase AI with Gemini model
- **Maps & Location**: Google Maps Flutter + Geocoding services
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
- `firebase_ai`: AI capabilities
- `flutter_ai_toolkit`: AI chat components
- `location_picker_flutter_map`: Pick location from map
- `geocoding`: Address geocoding services

## 🚀 Getting Started

1. Clone the repository:
   ```
   git clone https://github.com/abderazak-py/snap_shop
   cd snap_shop
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Configure Supabase:
   - Create a Supabase project
   - Update the Supabase credentials in `lib/core/utils/supabase_service.dart`

4. Configure Google Maps (NEW):
   - Add your Google Maps API key to `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`
   - Enable Maps SDK and Geocoding API in Google Cloud Console

5. Run the application:
   ```
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
│   ├── address/         
│   ├── auth/
│   ├── cart/
│   ├── chat/
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
4. Firebase AI configuration for AI chat functionality
5. Google Maps API key for address features

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
