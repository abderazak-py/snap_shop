# Snap Shop

A modern e-commerce mobile application built with Flutter, featuring a clean architecture pattern and integrated with Supabase backend services.

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
  - Payment: Checkout and order processing
  - Product: Product catalog and details
  - Profile: User profile management
  - Search: Product search capabilities
  - Settings: Application preferences
  - Splash: Initial loading screen

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
