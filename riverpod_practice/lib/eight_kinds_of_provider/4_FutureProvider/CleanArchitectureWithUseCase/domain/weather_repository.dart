import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/forecast_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_entity.dart';

// Domain Layer — Repository Interface (Abstract)
// Defines WHAT the app can do, not HOW it does it.
// The data layer provides the concrete implementation.
//
// This interface mirrors a typical REST API surface:
//   GET    /v1/weather?city=X        → getWeather
//   GET    /v1/forecast?city=X&days=N → getForecast
//   GET    /v1/cities/search?q=X     → searchCities
//   GET    /v1/favorites             → getFavoriteCities
//   POST   /v1/favorites             → addFavoriteCity
//   PUT    /v1/favorites/{id}        → updateFavoriteCity
//   DELETE /v1/favorites/{id}        → removeFavoriteCity

abstract class WeatherRepository {
  // GET — current weather for a city
  Future<WeatherEntity> getWeather({required String city});

  // GET — multi-day forecast
  Future<ForecastEntity> getForecast({
    required String city,
    int days = 7,
  });

  // GET — city autocomplete / search
  Future<List<CityEntity>> searchCities({required String query});

  // GET — list all favorites for the current user
  Future<List<FavoriteCityEntity>> getFavoriteCities();

  // POST — add a favorite
  Future<FavoriteCityEntity> addFavoriteCity({required String city});

  // PUT — replace an existing favorite
  Future<FavoriteCityEntity> updateFavoriteCity({
    required String id,
    required String city,
  });

  // DELETE — remove a favorite
  Future<void> removeFavoriteCity({required String id});
}
