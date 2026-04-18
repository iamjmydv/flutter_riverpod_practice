import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Get Favorite Cities
// Load the user's saved favorite list.

class GetFavoriteCitiesUseCase {
  final WeatherRepository _repository;

  GetFavoriteCitiesUseCase(this._repository);

  Future<List<FavoriteCityEntity>> call() {
    return _repository.getFavoriteCities();
  }
}
