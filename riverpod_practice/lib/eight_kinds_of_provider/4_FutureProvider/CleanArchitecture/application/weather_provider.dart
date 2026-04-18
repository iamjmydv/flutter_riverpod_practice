import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/application/weather_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/domain/weather_entity.dart';

// Application Layer — Providers
// All providers live here. This is the glue between layers.
//
// Repository provider lives in weather_repository_provider.dart
// to keep dependency injection isolated and easy to override in tests.

// Re-export so the presentation layer only needs one import
export 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/application/weather_repository_provider.dart';

// FutureProvider — watches the repository and calls the async method.
// autoDispose: automatically cleans up when no longer listened to.
// The return type is automatically wrapped in AsyncValue<Weather>.
final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  return weatherRepository.getWeather(city: 'London');
});

// FutureProvider overview:
//
// 1. Define a FutureProvider that returns a Future<T>
// 2. When you ref.watch() it, the return type is AsyncValue<T>
// 3. AsyncValue has three states: loading, error, data
// 4. Use .when() to map each state to a widget
//
// autoDispose modifier:
//   Cancels the Future and frees resources when no widget is listening.
//   Recommended for one-off API calls so data is re-fetched on revisit.
//
// Clean Architecture benefit:
//   To swap from fake API to real API, just change WeatherRepositoryImpl
//   in weather_repository_provider.dart — no other file needs to change.
