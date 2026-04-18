import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/usecase_providers.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';

// Application Layer — FutureProviders (what the UI watches)
//
// The UI watches this. Riverpod wraps the future in AsyncValue<WeatherEntity>,
// so the page can render loading / error / data states cleanly.

final weatherFutureProvider =
    FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);
  return getWeather(city: 'London');
});
