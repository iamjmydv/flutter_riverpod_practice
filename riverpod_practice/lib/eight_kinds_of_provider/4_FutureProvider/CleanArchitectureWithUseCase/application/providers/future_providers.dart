import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/usecase_providers.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Application Layer — FutureProviders (what the UI watches)
//
// The UI watches `weatherFutureProvider`, which recomputes whenever the
// user changes `cityQueryProvider` via the search box.

final cityQueryProvider = StateProvider<String>((ref) => 'London');

final weatherFutureProvider =
    FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  final city = ref.watch(cityQueryProvider);
  return getWeather(city: city);
});
