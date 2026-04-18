import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/get_weather_usecase_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Application Layer — FutureProviders
//
// READ-only screens use FutureProviders. They watch a use case and
// call it — the result is wrapped in AsyncValue<T> automatically.
//
// WRITE actions (add/update/delete) are invoked imperatively from UI
// callbacks via `ref.read(xUseCaseProvider)(...)` — no FutureProvider
// needed because they aren't "state to watch", they are "actions to run".

// Re-exports so the UI imports only this one file
export 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/get_weather_usecase_provider.dart';
export 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/weather_repository_provider.dart';

// ── READ providers ──────────────────────────────────────────────────────────

// Current weather for a fixed city (simplest case).
final weatherFutureProvider =
    FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  return getWeather(city: 'London');
});

// Forecast for a fixed city.
final forecastFutureProvider =
    FutureProvider.autoDispose<ForecastEntity>((ref) {
  final getForecast = ref.watch(getForecastUseCaseProvider);
  return getForecast(city: 'London', days: 3);
});

// User's favorite list.
final favoriteCitiesFutureProvider =
    FutureProvider.autoDispose<List<FavoriteCityEntity>>((ref) {
  final getFavorites = ref.watch(getFavoriteCitiesUseCaseProvider);
  return getFavorites();
});

// Layer overview:
//
//   presentation
//       ↓ ref.watch / ref.read
//   application  (providers: repository, use cases, future providers)
//       ↓
//   domain       (entities, abstract repository, use cases)
//       ↑ implements
//   data         (models, concrete repository)
//       ↓ HTTP
//   API / Backend
//
// To swap fake → real API: change WeatherRepositoryImpl in
// weather_repository_provider.dart. Every other file stays the same.
