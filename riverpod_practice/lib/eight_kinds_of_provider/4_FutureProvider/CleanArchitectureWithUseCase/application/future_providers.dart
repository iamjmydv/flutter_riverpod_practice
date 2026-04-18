import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/usecase_providers.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Application Layer — FutureProviders (read-only state the UI watches)
//
// READ-only screens use FutureProviders. They watch a use case and
// call it — the result is wrapped in AsyncValue<T> automatically.
//
// WRITE actions (add/update/delete) are invoked imperatively from UI
// callbacks via `ref.read(xUseCaseProvider)(...)` — no FutureProvider
// needed because they aren't "state to watch", they are "actions to run".
//
// Layer overview:
//
//   presentation
//       ↓ ref.watch / ref.read
//   application  (repository provider, use case providers, future providers)
//       ↓
//   domain       (entities, abstract repository, use cases)
//       ↑ implements
//   data         (models, concrete repository)
//       ↓ HTTP
//   API / Backend

final weatherFutureProvider =
    FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  return getWeather(city: 'London');
});

final forecastFutureProvider =
    FutureProvider.autoDispose<ForecastEntity>((ref) {
  final getForecast = ref.watch(getForecastUseCaseProvider);
  return getForecast(city: 'London', days: 3);
});

final favoriteCitiesFutureProvider =
    FutureProvider.autoDispose<List<FavoriteCityEntity>>((ref) {
  final getFavorites = ref.watch(getFavoriteCitiesUseCaseProvider);
  return getFavorites();
});
