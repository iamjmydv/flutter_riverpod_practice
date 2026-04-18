import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/city_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/weather_repository.dart';

// Use Case — Search Cities
// Autocomplete-style city lookup.

class SearchCitiesUseCase {
  final WeatherRepository _repository;

  SearchCitiesUseCase(this._repository);

  Future<List<CityEntity>> call({required String query}) {
    // Business rule: empty or too-short queries return nothing
    // (instead of hitting the API for 0-1 character searches).
    if (query.trim().length < 2) return Future.value(const []);
    return _repository.searchCities(query: query.trim());
  }
}
