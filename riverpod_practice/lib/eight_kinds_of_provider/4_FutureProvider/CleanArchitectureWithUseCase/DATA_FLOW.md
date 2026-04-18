# Data Flow — From the Root Folder to the UI

This doc follows a single user action — *"show weather for London"* — from the **outermost layer** all the way down to the network, and back up to the screen.

If you read this top-to-bottom once, the rest of the project will make sense.

---

## The 4 Top-Level Folders (and the order data passes through them)

```
CleanArchitectureWithUseCase/
├── domain/         ← the rules (pure Dart)
├── data/           ← the plumbing (HTTP, JSON)
├── application/    ← the wiring (Riverpod DI)
└── presentation/   ← the screen (Flutter widgets)
```

**Important:** data does NOT travel in the order the folders are listed. It flows like this:

```
presentation  →  application  →  domain  →  data  →  (network)
     ↑                                                   │
     └───────────────── result bubbles back up ──────────┘
```

The **domain** folder is the center of the app. Everything else points AT it.

---

## The Request: What Happens When You Open the Page

Open [presentation/pages/future_provider_page.dart](presentation/pages/future_provider_page.dart). The widget says:

```dart
final weatherAsync = ref.watch(weatherFutureProvider);
```

That one line is the start of a 7-step chain. Follow it:

### Step 1 — UI asks the Application layer

The page `watch`es `weatherFutureProvider` (lives in [application/providers/future_providers.dart](application/providers/future_providers.dart)).

The UI knows **nothing else**. It does not know about HTTP, JSON, repositories, or entities. It just trusts that Riverpod will hand back an `AsyncValue<WeatherEntity>`.

### Step 2 — Application reads the city and the use case

```dart
final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  final city = ref.watch(cityQueryProvider);
  return getWeather(city: city);
});
```

The application layer is **pure wiring** — it grabs the `GetWeatherUseCase` (from [application/providers/usecase_providers.dart](application/providers/usecase_providers.dart)) and calls it. No business logic, no HTTP.

### Step 3 — Use case runs business rules (domain)

Control jumps into [domain/usecases/get_weather_usecase.dart](domain/usecases/get_weather_usecase.dart):

```dart
Future<WeatherEntity> call({required String city}) {
  return _repository.getWeather(city: city);
}
```

Today it only delegates. Tomorrow it's where **validation, unit conversion, analytics, and caching** go. The use case is the guardian of business rules — see [USE_CASE.md](USE_CASE.md).

### Step 4 — Use case asks the Repository *contract*

The use case talks to the **abstract** `WeatherRepository` in [domain/repositories/weather_repository.dart](domain/repositories/weather_repository.dart).

It does not know which implementation is plugged in. That's why the demo can swap the fake service for a real HTTP one without touching the domain.

### Step 5 — Implementation fulfils the contract (data)

Riverpod's DI plugged in [data/repositories/weather_repository_impl.dart](data/repositories/weather_repository_impl.dart). It now runs:

```dart
final json = await _api.getWeather(city: city);
return WeatherModel.fromJson(json);
```

Two jobs: fetch raw JSON via the API service, then convert it to a domain entity using a Model. **This is the only place in the app where JSON meets domain types.**

### Step 6 — API service hits the network

[data/data_sources/remote/weather_api_service_impl.dart](data/data_sources/remote/weather_api_service_impl.dart) returns a `Map<String, dynamic>` — raw JSON.

In the demo it returns fake data after a 1-second delay. In production this would be a Dio/http call.

### Step 7 — JSON climbs back up, turning into an Entity

```
{ "city": "London", "temperature": 15.0, "condition": "Sunny" }  ← raw JSON
        │
        ▼  WeatherModel.fromJson(json)                             (data/models)
        │
WeatherModel(city: "London", temperature: 15.0, condition: "Sunny") ← still a data-layer type
        │
        ▼  returned as WeatherEntity (Model extends Entity)
        │
WeatherEntity ← what the domain, application, and UI see
```

By the time it reaches the UI, every trace of JSON is gone.

### Step 8 — UI rebuilds

The `FutureProvider` completes. Riverpod marks the widget dirty. The page rebuilds, and `weatherAsync.when(...)` renders the `data` branch with the city name and temperature.

---

## Full Call Chain (ASCII)

```
┌─────────────────────────────────────────┐
│ FutureProviderPage  (presentation)      │
│   ref.watch(weatherFutureProvider)      │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│ weatherFutureProvider  (application)    │
│   ref.watch(getWeatherUseCaseProvider)  │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│ GetWeatherUseCase  (domain)             │
│   _repository.getWeather(...)           │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│ WeatherRepository  (domain — abstract)  │
│   — contract only, no code runs here —  │
└────────────────┬────────────────────────┘
                 │   (Riverpod picks the impl)
                 ▼
┌─────────────────────────────────────────┐
│ WeatherRepositoryImpl  (data)           │
│   json = await _api.getWeather(...)     │
│   return WeatherModel.fromJson(json)    │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│ WeatherApiServiceImpl  (data)           │
│   returns Map<String, dynamic>          │
└─────────────────────────────────────────┘
```

Each box has **one** job. If a change touches two boxes, check whether it's really two changes in disguise.

---

## The Dependency Rule (the single rule that makes this work)

> **Inner layers must not import outer layers.**

| This layer | Can import | Must NOT import |
|---|---|---|
| presentation | application | data, domain types directly |
| application | domain + data impls | Flutter widgets |
| domain | **nothing** in this project | Riverpod, Flutter, Dio, JSON |
| data | domain | Riverpod, Flutter |

Domain is at the bottom of the import graph. It depends on nothing. That's what lets you unit-test use cases without mocking Riverpod, and keeps your business rules portable.

---

## A Mental Model: "The Restaurant"

| Layer | Restaurant role |
|---|---|
| **presentation** | The diner — says "I'd like the weather, please" |
| **application** | The waiter — takes the order, knows the kitchen, doesn't cook |
| **domain** | The recipe book — says WHAT must be done, in what order |
| **data** | The kitchen — actually cooks (fetches, parses) |
| **Model → Entity** | Plating — raw ingredients arrive as a clean dish |

Swapping the kitchen (fake JSON → real HTTP) doesn't change the recipe, the waiter, or what the diner orders.

---

## Where to Add New Things — Quick Lookup

| You want to add… | Put it in… |
|---|---|
| New screen | `presentation/pages/` |
| New business rule (validation, conversion) | `domain/usecases/` |
| New domain field (e.g. `humidity`) | `domain/entities/` + `data/models/` |
| New endpoint | `data/data_sources/remote/` + new method on the repository contract |
| Local caching | New `data/data_sources/local/` + update `WeatherRepositoryImpl` |
| Swap fake for real API | `data/data_sources/remote/weather_api_service_impl.dart` |
| Expose new state to UI | `application/providers/` |

---

## See Also

- [CLEAN_ARCHITECTURE.md](CLEAN_ARCHITECTURE.md) — overview of the layers
- [USE_CASE.md](USE_CASE.md) — why use cases exist
- Every folder has a `README.md` explaining its job in one page
