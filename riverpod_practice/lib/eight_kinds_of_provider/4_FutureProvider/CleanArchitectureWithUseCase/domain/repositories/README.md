# `domain/repositories/`

> **Contracts**, not implementations. Abstract classes that say *what data operations the domain needs* — never *how* to do them.

A repository contract is the line drawn between *business rules* (domain) and *plumbing* (data). Use cases depend on the contract. The actual HTTP/database code lives in [`data/repositories/`](../../data/repositories/README.md) and plugs in at runtime via Riverpod.

---

## Golden rules

1. **Abstract only.** No `impl`, no Dio, no SharedPreferences.
2. **Speaks in entities.** Method signatures use `WeatherEntity`, never `Map<String, dynamic>`.
3. **Describes WHAT, not HOW.** "`getWeather(city:)`" — not "`httpGet(url:)`".

## Why this indirection?

If the use case talked to a concrete `WeatherRepositoryImpl` directly:

- You couldn't unit-test the use case without a real HTTP client.
- Switching providers (OpenWeatherMap → WeatherAPI) would ripple into the domain.
- The domain would depend on the data layer, violating the dependency rule.

With a contract:

- Tests pass in a `FakeWeatherRepository` — zero network.
- The data layer can be rewritten end-to-end and the domain doesn't notice.

---

## The pattern

```dart
abstract class WeatherRepository {
  Future<WeatherEntity> getWeather({required String city});
}
```

That's the whole file. The implementation lives somewhere else.

---

## Current contract

- [`weather_repository.dart`](weather_repository.dart) — defines `getWeather(city:)`.

Implementation: [`../../data/repositories/weather_repository_impl.dart`](../../data/repositories/weather_repository_impl.dart)
