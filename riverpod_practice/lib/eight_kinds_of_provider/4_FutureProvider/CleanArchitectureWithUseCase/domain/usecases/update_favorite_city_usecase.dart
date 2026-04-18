import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Update Favorite City
// Replace an existing favorite's city value.

class UpdateFavoriteCityUseCase {
  final WeatherRepository _repository;

  UpdateFavoriteCityUseCase(this._repository);

  Future<FavoriteCityEntity> call({
    required String id,
    required String city,
  }) {
    final trimmed = city.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('City must not be empty');
    }
    return _repository.updateFavoriteCity(id: id, city: trimmed);
  }
}
