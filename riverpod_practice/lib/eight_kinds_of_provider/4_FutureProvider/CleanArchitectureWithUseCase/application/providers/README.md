# `application/providers/`

> Every Riverpod `Provider` in the feature. One file per concern — so the dependency chain reads like a ladder.

---

## The files

| File | Provides | Depends on |
|---|---|---|
| [`weather_api_service_provider.dart`](weather_api_service_provider.dart) | `WeatherApiService` | — (the base of the chain) |
| [`weather_repository_provider.dart`](weather_repository_provider.dart)   | `WeatherRepository`   | `weatherApiServiceProvider` |
| [`usecase_providers.dart`](usecase_providers.dart)                       | `GetWeatherUseCase`   | `weatherRepositoryProvider` |
| [`future_providers.dart`](future_providers.dart)                         | `cityQueryProvider`, `weatherFutureProvider` (what the UI watches) | `getWeatherUseCaseProvider` |

Read the column "Depends on" top-down — it's the exact call chain [`DATA_FLOW.md`](../../DATA_FLOW.md) describes.

---

## Two categories inside this folder

### 1. DI providers (infrastructure wiring)

These just construct objects. They type their output as the **abstract** domain contract, not the concrete impl:

```dart
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(ref.watch(weatherApiServiceProvider));
});
```

Notice the `<WeatherRepository>` generic — not `<WeatherRepositoryImpl>`. That's what lets tests override the provider with a fake.

### 2. State providers (UI-facing)

```dart
final cityQueryProvider = StateProvider<String>((ref) => 'London');

final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  final city = ref.watch(cityQueryProvider);
  return getWeather(city: city);
});
```

These are the ONLY providers the UI imports. The UI never imports the DI providers directly — it goes through `weatherFutureProvider`.

---

## Testing pattern

Override any provider in this folder to swap a real dependency for a fake:

```dart
ProviderScope(
  overrides: [
    weatherRepositoryProvider.overrideWithValue(FakeWeatherRepository()),
  ],
  child: MyApp(),
)
```

Because every layer is typed against an abstract, you can replace any rung of the ladder without touching the others.

---

## What NOT to put here

- ❌ Business rules (those live in use cases)
- ❌ JSON parsing (that lives in models)
- ❌ Widget code
- ❌ Hard-coded URLs, API keys — inject them via their own provider (see the "REAL-WORLD API SAMPLE" in [`weather_api_service_provider.dart`](weather_api_service_provider.dart))
