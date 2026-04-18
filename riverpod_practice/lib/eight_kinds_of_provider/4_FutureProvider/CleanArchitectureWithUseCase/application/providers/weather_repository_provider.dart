import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/weather_api_service_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/repositories/weather_repository_impl.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Application Layer — Repository DI. Typed as the abstract interface.

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl(ref.watch(weatherApiServiceProvider));
});

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Repository with multiple data sources
// ─────────────────────────────────────────────────────────────
// When the repository needs remote + local cache:
//
// final weatherLocalDataSourceProvider =
//     Provider<WeatherLocalDataSource>((ref) {
//   return WeatherLocalDataSourceImpl(ref.watch(sharedPrefsProvider));
// });
//
// final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
//   return WeatherRepositoryImpl(
//     ref.watch(weatherApiServiceProvider),
//     ref.watch(weatherLocalDataSourceProvider),
//   );
// });
//
// For testing, override just this provider:
//   ProviderScope(overrides: [
//     weatherRepositoryProvider.overrideWithValue(FakeWeatherRepository()),
//   ])
// ─────────────────────────────────────────────────────────────

