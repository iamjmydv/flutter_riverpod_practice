# Clean Architecture with FutureProvider + Use Case

This folder is the same Clean Architecture setup as `CleanArchitecture/`, but with one extra layer inserted between the provider and the repository: the **Use Case**.

Same scenario (weather fetching). Same outcome. Same UI. The only difference is **where the business logic lives**.

---

## Folder Structure

```
CleanArchitectureWithUseCase/
├── domain/                                     (pure Dart, no dependencies)
│   ├── weather_entity.dart                     — core business objects
│   ├── forecast_entity.dart
│   ├── favorite_city_entity.dart
│   ├── weather_repository.dart                 — abstract interface
│   └── usecases/                               — ONE action per file
│       ├── get_weather_usecase.dart
│       ├── get_forecast_usecase.dart
│       ├── get_favorite_cities_usecase.dart
│       ├── add_favorite_city_usecase.dart
│       ├── update_favorite_city_usecase.dart
│       └── remove_favorite_city_usecase.dart
│
├── data/                                       (implements domain contracts)
│   ├── weather_model.dart                      — JSON serialization
│   ├── forecast_model.dart
│   ├── favorite_city_model.dart
│   └── weather_repository_impl.dart            — concrete API implementation
│
├── application/                                (providers, DI)
│   ├── weather_repository_provider.dart        — DI for the repository
│   ├── usecase_providers.dart                  — DI for every use case
│   └── future_providers.dart                   — FutureProviders the UI watches
│
└── presentation/                               (UI only)
    └── future_provider_page.dart               — page widget
```

---

## What changed vs. the plain `CleanArchitecture/` folder

| File | Plain | With Use Case |
|---|---|---|
| `domain/weather_entity.dart` | ✅ same | ✅ same |
| `domain/weather_repository.dart` | ✅ same | ✅ same |
| `domain/usecases/*.dart` | ❌ | ✅ **NEW** |
| `data/weather_model.dart` | ✅ same | ✅ same |
| `data/weather_repository_impl.dart` | ✅ same | ✅ same |
| `application/weather_repository_provider.dart` | ✅ same | ✅ same |
| `application/usecase_providers.dart` | ❌ | ✅ **NEW** |
| `application/future_providers.dart` | calls **repository** | calls **use case** |
| `presentation/future_provider_page.dart` | ✅ identical | ✅ identical |

The UI doesn't change. That's a good sign — the use case is an internal detail.

---

## Call Chain at Runtime

```
UI
 └─ weatherFutureProvider        (application)
     └─ GetWeatherUseCase        (domain)
         └─ WeatherRepository    (domain interface)
             └─ WeatherRepositoryImpl   (data)
                 └─ HTTP / database / whatever
```

Each hop has ONE job. No layer has two responsibilities.

---

## Why Add a Use Case?

See [USE_CASE.md](./USE_CASE.md) for the full explanation with examples.

Short version:

- **Repository** = "how to fetch data" (API, DB)
- **Use Case** = "what the app actually does" (business rules)
- **Provider** = "how Riverpod wires it up" (state management)

Without the use case, business logic sneaks into the provider or the widget. With the use case, it has a dedicated home.

---

## How to Run

Update `main.dart`:

```dart
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/presentation/future_provider_page.dart';
```

The `FutureProviderPage` class name is the same — only the import path changes.
