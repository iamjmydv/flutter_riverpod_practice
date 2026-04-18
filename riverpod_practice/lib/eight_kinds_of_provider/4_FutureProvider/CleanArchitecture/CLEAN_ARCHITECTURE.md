# Clean Architecture with FutureProvider

This folder mirrors the same Clean Architecture layout used in `8_AsyncNotifierProvider/`, but with **FutureProvider** as the state management primitive.

The scenario is identical to the flat version one folder up (weather fetching), so you can compare side-by-side how the same feature looks before and after applying Clean Architecture.

---

## Folder Structure

```
4_FutureProvider/CleanArchitecture/
├── domain/                              (pure Dart, no dependencies)
│   ├── weather_entity.dart              — core business object
│   └── weather_repository.dart          — abstract interface
│
├── data/                                (implements domain contracts)
│   ├── weather_model.dart               — JSON serialization/deserialization
│   └── weather_repository_impl.dart     — concrete API implementation
│
├── application/                         (providers, DI)
│   ├── weather_repository_provider.dart — repository provider (DI)
│   └── weather_provider.dart            — FutureProvider definition
│
└── presentation/                        (UI only)
    └── future_provider_page.dart        — page widget
```

---

## The 4 Layers

### 1. Domain Layer (The "What")
- **Entity** — `Weather` (pure Dart class)
- **Repository Interface** — `WeatherRepository` (abstract)

ZERO dependencies on Flutter, Riverpod, or any package.

### 2. Data Layer (The "How")
- **Model** — `WeatherModel` extends `Weather` with JSON helpers
- **Repository Implementation** — `WeatherRepositoryImpl` (simulated network call)

### 3. Application Layer (The "Glue")
- **Repository Provider** — types as `WeatherRepository`, returns `WeatherRepositoryImpl()`
- **FutureProvider** — `weatherFutureProvider` calls the repository

### 4. Presentation Layer (The "Look")
- **Page** — `FutureProviderPage` watches the provider and renders `AsyncValue<Weather>`

---

## Dependency Rule

```
presentation  -->  application  -->  domain  <--  data
   (UI)            (state)         (core)       (API)
```

- `domain/` has ZERO imports from other layers
- `data/` only imports from `domain/`
- `application/` imports from `domain/` and `data/`
- `presentation/` only imports from `application/`

---

## FutureProvider vs AsyncNotifierProvider

Both produce `AsyncValue<T>`, both work the same with `.when()`. The difference:

| Feature                 | FutureProvider              | AsyncNotifierProvider       |
|-------------------------|-----------------------------|-----------------------------|
| Initial async fetch     | ✅ via the provider body    | ✅ via `build()`            |
| Methods to mutate state | ❌ (re-create only)         | ✅ (any async method)       |
| Best for                | Read-only async data        | Async data + user actions   |

For pure read-only fetches (like this weather scenario), **FutureProvider** is the simpler choice. Reach for `AsyncNotifierProvider` when the user needs to update or mutate the fetched data.

---

## How to Run

Update `main.dart` to import this page instead of the flat one:

```dart
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/presentation/future_provider_page.dart';
```

The `FutureProviderPage` class name is the same — only the import path changes.
