# Clean Architecture with FutureProvider + Use Case

A minimal clean-architecture demo: **one feature (get weather)** wired through every layer so the flow is easy to see.

Inspired by the [MVVM/BLoC/Dio article](https://medium.com/@yamen.abd98/clean-architecture-in-flutter-mvvm-bloc-dio-79b1615530e1), adapted to Riverpod.

---

## Folder Structure

```
CleanArchitectureWithUseCase/
├── domain/                                     (pure Dart, no dependencies)
│   ├── entities/
│   │   └── weather_entity.dart                 — core business object
│   ├── repositories/
│   │   └── weather_repository.dart             — abstract contract
│   └── usecases/
│       └── get_weather_usecase.dart            — one action, business rules
│
├── data/                                       (implements domain contracts)
│   ├── data_sources/
│   │   └── remote/
│   │       ├── weather_api_service.dart        — abstract HTTP contract
│   │       └── weather_api_service_mock.dart   — fake JSON for the demo
│   ├── models/
│   │   └── weather_model.dart                  — JSON ↔ entity mapping
│   └── repositories/
│       └── weather_repository_impl.dart        — wires service + model
│
├── application/                                (providers, DI)
│   └── providers/
│       ├── weather_api_service_provider.dart   — DI: mock vs real HTTP
│       ├── weather_repository_provider.dart    — DI: repository
│       ├── usecase_providers.dart              — DI: use cases
│       └── future_providers.dart               — what the UI watches
│
└── presentation/                               (UI only)
    └── pages/
        └── future_provider_page.dart           — the screen
```

---

## The Call Chain

```
UI (FutureProviderPage)
 └─ weatherFutureProvider             (application)
     └─ GetWeatherUseCase             (domain — business rules)
         └─ WeatherRepository         (domain — abstract)
             └─ WeatherRepositoryImpl (data — JSON → Entity)
                 └─ WeatherApiService         (data — abstract)
                     └─ WeatherApiServiceMock (data — fake JSON)
                        ✨ swap for WeatherApiServiceImpl (real Dio) in prod
```

Each hop has ONE job. No layer has two responsibilities.

---

## Who depends on whom

| Layer | Knows about | Does NOT know about |
|---|---|---|
| **presentation** | providers | anything else |
| **application** | domain + data impls | Flutter widgets |
| **domain** | itself only | Riverpod, Dio, Flutter, JSON |
| **data** | domain | Riverpod, Flutter |

The domain layer is pure Dart — it could be copied into a server or a CLI app without changes.

---

## The Mock API Service

The demo runs with **no backend**. That's possible because the data layer is split:

| File | Job |
|---|---|
| `data_sources/remote/weather_api_service.dart` | Abstract — defines the HTTP surface. Returns raw JSON. |
| `data_sources/remote/weather_api_service_mock.dart` | Concrete — hardcoded JSON + `Future.delayed` for realism. |
| `repositories/weather_repository_impl.dart` | Takes the JSON, parses via `WeatherModel.fromJson`, returns `WeatherEntity`. |

Nothing above the data layer knows the mock exists. To go live:

```dart
// application/providers/weather_api_service_provider.dart
final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  // Demo:
  return WeatherApiServiceMock();

  // Production (real HTTP):
  // final dio = Dio(BaseOptions(baseUrl: 'https://api.weatherapp.com/v1'));
  // return WeatherApiServiceImpl(dio);
});
```

One line. Everything above — repository, use case, providers, UI — keeps working unchanged.

---

## Why Add a Use Case?

See [USE_CASE.md](./USE_CASE.md) for the full explanation with examples.

Short version:

- **Repository** = "how to fetch data" (HTTP, DB)
- **Use Case**   = "what the app actually does" (business rules)
- **Provider**   = "how Riverpod wires it up" (state management)

Right now `GetWeatherUseCase` just delegates to the repository. That looks pointless — **it isn't**. It's the dedicated home for business rules that WILL show up: validation, unit conversion, caching, analytics. When those arrive, they land in the use case and nothing else moves.

---

## How to Run

In `main.dart`:

```dart
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/presentation/pages/future_provider_page.dart';

// ... then show `const FutureProviderPage()` somewhere.
```
