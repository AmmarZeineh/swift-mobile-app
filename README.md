# Swift — E-Commerce Marketplace App

A Flutter marketplace app with **two sides in one codebase**: sellers list and manage their products and handle orders,
and customers browse, search, add to cart and place orders. The backend runs on **Supabase**.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase&logoColor=white)
![BLoC](https://img.shields.io/badge/State-BLoC%2FCubit-blue)

<!-- Screenshots: add images to docs/screenshots/ and list them here, e.g.
<p align="center"><img src="docs/screenshots/seller-home.png" width="230"> <img src="docs/screenshots/cart.png" width="230"></p>
-->

## Features

**Seller**
- Sign up and log in as a seller
- Product dashboard: list, view and manage products
- Add products with images (compressed before upload) and attributes
- Seller profile

**Customer**
- Sign up and log in as a customer
- Home feed with product grid and search
- Product details with reviews
- Cart, checkout and order history with order items

**Shared**
- Onboarding flow
- Forced / optional app-update check, driven from a Supabase `app_config` table
- Localization with `intl` (ARB files)

## Architecture

```
lib/
├── core/        # shared cubits, entities, models, repos, services (Supabase, storage, app update), widgets
└── features/
    ├── onboarding/
    ├── seller/  # auth, home, add_product, profile   → data / domain / presentation
    └── client/  # auth, home, product_details, cart, order, profile
```

- Feature-first Clean Architecture with `data` / `domain` / `presentation` layers.
- State management with BLoC/Cubit; dependency injection with `get_it`.
- Repositories return `Either<Failure, T>` (`dartz`).

## Tech stack

Flutter · Dart · flutter_bloc · get_it · supabase_flutter · dartz · cached_network_image · image_picker ·
flutter_image_compress · flutter_screenutil · intl · shared_preferences · package_info_plus

## Getting started

```bash
flutter pub get
flutter run
```

The Supabase keys are kept out of git. Create `lib/app_keys.dart`:

```dart
class AppKeys {
  static const url = 'https://<your-project>.supabase.co';
  static const annon = '<your-anon-key>';
}
```

## Author

**Ammar Zeineh**, Flutter Developer · [LinkedIn](https://linkedin.com/in/ammar-zeineh) · [GitHub](https://github.com/AmmarZeineh)
