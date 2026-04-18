import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Add Favorite City
// Save a new city to the user's favorites.

class AddFavoriteCityUseCase {
  final WeatherRepository _repository;

  AddFavoriteCityUseCase(this._repository);

  Future<FavoriteCityEntity> call({required String city}) {
    // Business rule: trim + validate before hitting the network.
    final trimmed = city.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('City must not be empty');
    }
    return _repository.addFavoriteCity(city: trimmed);
  }
}
