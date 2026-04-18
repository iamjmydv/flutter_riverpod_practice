import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/get_weather_usecase_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Application Layer — FutureProvider
// Notice this provider watches the USE CASE, NOT the repository directly.
//
// Flow:
//   Provider → UseCase → Repository → API
//
// Why add the use case in the middle?
//   - Keeps business logic OUT of the provider
//   - The provider's only job is Riverpod wiring
//   - If you need to validate, transform, or combine data → do it in the use case

// Re-export so the presentation layer only needs one import
export 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/get_weather_usecase_provider.dart';
export 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/weather_repository_provider.dart';

// FutureProvider — invokes the use case (not the repository).
// autoDispose: automatically cleans up when no longer listened to.
// The return type is automatically wrapped in AsyncValue<WeatherEntity>.
final weatherFutureProvider = FutureProvider.autoDispose<WeatherEntity>((ref) {
  final getWeather = ref.watch(getWeatherUseCaseProvider);

  // call() makes the use case invokable like a function.
  // Equivalent to: return getWeather.call(city: 'London');
  return getWeather(city: 'London');
});


// Layer overview (with use case):
//
// presentation → application → domain ← data
//                                 ↑
//                            use case lives here
//
// The use case is a domain-layer object. The application layer just
// creates it (via provider) and calls it.
//
// Clean Architecture benefit:
//   To swap from fake API to real API, change WeatherRepositoryImpl in
//   weather_repository_provider.dart — the use case and provider don't move.
