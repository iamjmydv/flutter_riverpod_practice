import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Remove Favorite City
// Delete a favorite by its server-assigned ID.

class RemoveFavoriteCityUseCase {
  final WeatherRepository _repository;

  RemoveFavoriteCityUseCase(this._repository);

  Future<void> call({required String id}) {
    return _repository.removeFavoriteCity(id: id);
  }
}
