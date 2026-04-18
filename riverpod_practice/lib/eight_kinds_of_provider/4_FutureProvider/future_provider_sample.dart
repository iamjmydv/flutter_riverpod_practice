import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/weather_repository.dart';

// FutureProvider is used for asynchronous operations that return a Future.
// Common use cases: API calls, database queries, file reads, etc.

// Provider for the repository (plain Provider since it's a synchronous value)
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});

// FutureProvider — watches the repository and calls the async method.
// autoDispose: automatically cleans up when no longer listened to.
// The return type is automatically wrapped in AsyncValue<Weather>.
final weatherFutureProvider = FutureProvider.autoDispose<WeatherModel>((ref) {
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
// Use cases:
//   - Perform and cache async operations (network requests)
//   - Handle loading & error states without manual flags
//   - Combine multiple async values into one
//   - Pull-to-refresh with ref.refresh(provider)
