# `data/repositories/`

> **Implements the domain contracts.** This is where "fetch raw JSON → parse via Model → return Entity" actually happens.

The domain declares *what* data operations exist ([`domain/repositories/`](../../domain/repositories/README.md)). This folder declares *how* they're performed.

---

## The typical recipe

```dart
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    final json = await _api.getWeather(city: city);   // 1. raw bytes from network
    return WeatherModel.fromJson(json);               // 2. into a domain-friendly shape
  }
}
```

Two hops, one responsibility: **fetch + translate**.

---

## Real-world responsibilities

In production, repositories often do a bit more:

- **Combine sources:** try remote, fall back to local cache on network error.
- **Cache writes:** save successful responses to the local data source.
- **Error translation:** turn `DioException` / `SocketException` into domain-level failures (`NoInternetFailure`, `BadResponseFailure`).

All of that still lives here — NOT in the use case, NOT in the provider, NOT in the API service.

See the "REAL-WORLD API SAMPLE" comment in [`weather_repository_impl.dart`](weather_repository_impl.dart) for a fuller example.

---

## Allowed imports

| From | Reason |
|---|---|
| `domain/entities/`     | To return them |
| `domain/repositories/` | To implement them |
| `data/data_sources/`   | To fetch raw data |
| `data/models/`         | To parse JSON |

NOT allowed: `application/`, `presentation/`, Flutter, Riverpod.

---

## Current implementation

- [`weather_repository_impl.dart`](weather_repository_impl.dart) — implements `WeatherRepository`.
