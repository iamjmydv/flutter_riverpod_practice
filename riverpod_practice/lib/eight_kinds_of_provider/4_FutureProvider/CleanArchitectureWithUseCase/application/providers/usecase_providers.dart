import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/providers/weather_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_weather_usecase.dart';

// Application Layer — Use Case DI.

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  return GetWeatherUseCase(ref.watch(weatherRepositoryProvider));
});

// ─────────────────────────────────────────────────────────────
// REAL-WORLD API SAMPLE — Multiple use cases, one provider each
// ─────────────────────────────────────────────────────────────
// Each use case represents one business action. Keep them granular
// so widgets can depend only on what they actually need.
//
// final getForecastUseCaseProvider = Provider<GetForecastUseCase>((ref) {
//   return GetForecastUseCase(ref.watch(weatherRepositoryProvider));
// });
//
// final addFavoriteCityUseCaseProvider =
//     Provider<AddFavoriteCityUseCase>((ref) {
//   return AddFavoriteCityUseCase(ref.watch(favoritesRepositoryProvider));
// });
//
// final searchCitiesUseCaseProvider = Provider<SearchCitiesUseCase>((ref) {
//   return SearchCitiesUseCase(ref.watch(weatherRepositoryProvider));
// });
// ─────────────────────────────────────────────────────────────

