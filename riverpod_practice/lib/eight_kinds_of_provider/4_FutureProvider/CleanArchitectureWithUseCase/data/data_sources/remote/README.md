# `data/data_sources/remote/`

> Network data sources — the files that actually perform HTTP requests (or pretend to, in demo mode).

---

## Files

| File | Role |
|---|---|
| [`weather_api_service.dart`](weather_api_service.dart) | Abstract — declares every endpoint the app uses. Returns raw `Map<String, dynamic>`. |
| [`weather_api_service_impl.dart`](weather_api_service_impl.dart) | Concrete — today returns fake JSON after a 1-second delay. Replace the body with real Dio calls to go live. |

---

## The fake-vs-real swap

The demo works with no backend because `WeatherApiServiceImpl.getWeather` is just:

```dart
await Future.delayed(const Duration(seconds: 1));
return { 'city': ..., 'temperature': ..., 'condition': ... };
```

Swap that body for a Dio call (example inside the file) and the app becomes a real weather client. **No other file changes.**

---

## Adding more endpoints

1. Add the abstract method to `weather_api_service.dart`:
   ```dart
   Future<Map<String, dynamic>> getForecast({required String city, int days = 5});
   ```
2. Implement it in `weather_api_service_impl.dart`.
3. Add a matching method to the domain repository contract.
4. Wire it through `WeatherRepositoryImpl`.
5. Add a use case if business rules apply.

---

## What NOT to do here

- ❌ Don't parse JSON into an entity — that's the [Model's](../../models/README.md) job.
- ❌ Don't apply validation — that's the use case's job.
- ❌ Don't read settings or user preferences — pass them in.
- ❌ Don't read from Riverpod here — DI happens in [`application/providers/`](../../../application/providers/README.md).
