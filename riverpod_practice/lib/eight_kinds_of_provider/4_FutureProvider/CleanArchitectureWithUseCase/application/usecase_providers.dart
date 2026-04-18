import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/weather_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/add_favorite_city_usecase.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_favorite_cities_usecase.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_forecast_usecase.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/get_weather_usecase.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/remove_favorite_city_usecase.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/usecases/update_favorite_city_usecase.dart';

// Application Layer — Use Case Providers
// Each use case gets its own Provider so it can be injected individually.
// Every use case depends on the same repository, which is why they all
// watch `weatherRepositoryProvider`.

final getWeatherUseCaseProvider = Provider<GetWeatherUseCase>((ref) {
  return GetWeatherUseCase(ref.watch(weatherRepositoryProvider));
});

final getForecastUseCaseProvider = Provider<GetForecastUseCase>((ref) {
  return GetForecastUseCase(ref.watch(weatherRepositoryProvider));
});

final getFavoriteCitiesUseCaseProvider =
    Provider<GetFavoriteCitiesUseCase>((ref) {
  return GetFavoriteCitiesUseCase(ref.watch(weatherRepositoryProvider));
});

final addFavoriteCityUseCaseProvider = Provider<AddFavoriteCityUseCase>((ref) {
  return AddFavoriteCityUseCase(ref.watch(weatherRepositoryProvider));
});

final updateFavoriteCityUseCaseProvider =
    Provider<UpdateFavoriteCityUseCase>((ref) {
  return UpdateFavoriteCityUseCase(ref.watch(weatherRepositoryProvider));
});

final removeFavoriteCityUseCaseProvider =
    Provider<RemoveFavoriteCityUseCase>((ref) {
  return RemoveFavoriteCityUseCase(ref.watch(weatherRepositoryProvider));
});
