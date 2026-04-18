# What is a Use Case? (And why do I need one?)

> We already have a `Repository`. The `Provider` already calls it. Why add a `UseCase` in the middle?

Short answer: the repository is **"how to fetch data"**, the use case is **"what the app actually does with it"**.

In a tiny example, these look the same. In a real app, they aren't.

---

## The 3 roles, clearly separated

| Layer | Job | Example |
|---|---|---|
| **Repository** | Talk to the outside world | "HTTP GET `/weather?city=X`" |
| **Use Case** | Apply business rules to that data | "Get weather, convert to °F if user setting says so" |
| **Provider** | Wire it up with Riverpod | "Expose `AsyncValue<WeatherEntity>` to the UI" |

Each layer does ONE job. When a new rule appears, it's obvious where to put it.

---

## A Use Case is ONE action

Name use cases after **what the user is doing**, not after the data:

- ✅ `GetWeatherUseCase`
- ✅ `RefreshWeatherUseCase`
- ✅ `SearchCityUseCase`
- ✅ `AddFavoriteCityUseCase`
- ❌ `WeatherService` (too vague — what does it do?)
- ❌ `WeatherManager` (same problem)

If a class starts collecting many unrelated methods, **that's a sign it should be split into multiple use cases**.

---

## Day 1: Everything is simple

Your requirement: *"Show the weather for London."*

```dart
class GetWeatherUseCase {
  final WeatherRepository _repository;
  GetWeatherUseCase(this._repository);

  Future<WeatherEntity> call({required String city}) {
    return _repository.getWeather(city: city);
  }
}
```

Yes, this just delegates. The use case looks pointless today. **That's okay.** Keep reading.

---

## Day 60: The product team adds requirements

They send you a list:

1. *"Reject empty city names with a friendly error."*
2. *"If the user picked °F in settings, convert the temperature."*
3. *"Log an analytics event every time someone checks the weather."*
4. *"If the API fails, return the last cached weather instead."*

### ❌ Without a use case (logic in the provider)

Your `weather_provider.dart` becomes a dumping ground:

```dart
final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) async {
  final repo = ref.watch(weatherRepositoryProvider);
  final settings = ref.watch(settingsProvider);
  final analytics = ref.watch(analyticsProvider);
  final cache = ref.watch(weatherCacheProvider);

  const city = 'London';
  if (city.isEmpty) throw ArgumentError('City must not be empty');

  analytics.log('weather_checked', {'city': city});

  try {
    var weather = await repo.getWeather(city: city);
    if (settings.unit == TempUnit.fahrenheit) {
      weather = weather.copyWith(temperature: weather.temperature * 9/5 + 32);
    }
    cache.save(weather);
    return weather;
  } catch (e) {
    return cache.read(city) ?? (throw e);
  }
});
```

Now the provider is **four jobs at once**: validation, analytics, unit conversion, caching, AND Riverpod wiring. It's hard to test. It's hard to read. It's hard to reuse (what if another screen needs the same logic?).

### ✅ With a use case (logic where it belongs)

The **provider** stays tiny — its only job is Riverpod wiring:

```dart
final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  return getWeather(city: 'London');
});
```

The **use case** absorbs the business rules:

```dart
class GetWeatherUseCase {
  final WeatherRepository _repository;
  final SettingsRepository _settings;
  final Analytics _analytics;
  final WeatherCache _cache;

  GetWeatherUseCase(this._repository, this._settings, this._analytics, this._cache);

  Future<WeatherEntity> call({required String city}) async {
    if (city.isEmpty) throw ArgumentError('City must not be empty');

    _analytics.log('weather_checked', {'city': city});

    try {
      var weather = await _repository.getWeather(city: city);
      if (_settings.unit == TempUnit.fahrenheit) {
        weather = weather.copyWith(temperature: weather.temperature * 9/5 + 32);
      }
      _cache.save(weather);
      return weather;
    } catch (e) {
      return _cache.read(city) ?? (throw e);
    }
  }
}
```

Now:
- The **provider** is still 3 lines long. Unchanged except for DI wiring.
- The **repository** stays pure (HTTP only — no business logic pollution).
- The **use case** is easy to unit-test — just pass in fake dependencies.
- Another screen needing the same flow? Just watch the same use case provider.

---

## The `call()` trick

Dart lets you make a class **callable like a function** by defining a method named `call`:

```dart
class GetWeatherUseCase {
  Future<WeatherEntity> call({required String city}) { ... }
}

final getWeather = ref.watch(getWeatherUseCaseProvider);
getWeather(city: 'London');     // same as getWeather.call(city: 'London')
```

This reads more naturally at the call site — "use cases are verbs, and verbs are called."

---

## When do I NOT need a use case?

Be honest: for many small apps, use cases **are overkill**. If your provider is literally one line (`return repo.getWeather(city: 'London')`) and it will stay that way, you can skip them.

Add use cases when:
- The provider starts growing past a few lines of logic
- The same business rule shows up in 2+ providers
- You want unit tests without touching Riverpod
- Your team/codebase already uses them for consistency

Don't add them when:
- You're prototyping
- The app is a single screen with one API call
- "It's just a middleman" is actually true and stays true

---

## Comparison at a glance

|  | No Clean Architecture | Clean (no use case) | Clean + Use Case |
|---|---|---|---|
| UI touches | Everything | Only providers | Only providers |
| Provider contains | UI + API + rules | API call + Riverpod | Riverpod only |
| Repository contains | HTTP + rules + caching | HTTP | HTTP |
| Business rules live in | Scattered | Provider | Use case |
| Unit-testable without Riverpod? | ❌ | Partly | ✅ Fully |

---

## Rule of thumb

> If a provider starts growing past *"get the dependency and call one method"*, that growth belongs in a **use case**, not in the provider.

The provider's only job is Riverpod wiring. The use case's only job is business rules. The repository's only job is data access. Keep those three things apart and your codebase scales.
