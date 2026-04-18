# `domain/usecases/`

> **One action per class.** A use case represents a single thing the user — or system — wants to do.

Name use cases after the **verb**, not the data:

- `GetWeatherUseCase`
- `SearchCitiesUseCase`
- `AddFavoriteCityUseCase`
- `RefreshWeatherUseCase`

Avoid vague names like `WeatherManager` or `WeatherService`. If a class starts holding many unrelated methods, split it.

---

## What goes inside

A use case typically:

1. Takes one or more repository contracts via constructor injection.
2. Exposes one method — by convention, `call(...)` — so it can be invoked like a function.
3. Applies business rules: validation, unit conversion, composing multiple repositories, analytics, caching decisions, etc.
4. Returns an entity (or throws a domain-level exception).

```dart
class GetWeatherUseCase {
  final WeatherRepository _repository;
  GetWeatherUseCase(this._repository);

  Future<WeatherEntity> call({required String city}) {
    return _repository.getWeather(city: city);
  }
}
```

Today, the body is a single delegate. Tomorrow, it's where the rules live. See [../../USE_CASE.md](../../USE_CASE.md) for the full explanation and the "Day 60" example.

---

## Why `call()`?

Dart lets a class act like a function when it defines `call`. That means:

```dart
final getWeather = ref.watch(getWeatherUseCaseProvider);
await getWeather(city: 'London');   // reads as a verb, not a method lookup
```

Nicer at the call site. No other magic.

---

## When NOT to add a use case

If your provider is `return repo.doThing()` and will stay that way — skip it. Over-engineering hurts, too. Add a use case when rules show up, or when multiple providers need the same flow.

---

## Current use cases

- [`get_weather_usecase.dart`](get_weather_usecase.dart) — fetches weather for a given city.
