import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/models/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Data Layer — Repository Implementation
// Takes raw JSON from the API service, parses it via the Model,
// returns a domain Entity. That's the whole job.
//
// It depends on the ABSTRACT `WeatherApiService`, so the same code works
// whether the service is a mock, a real Dio client, or a test fake.

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    final json = await _api.getWeather(city: city);
    return WeatherModel.fromJson(json);
  }
}
