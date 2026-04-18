import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/data_sources/remote/weather_api_service.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/data/models/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/entities/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/repositories/weather_repository.dart';

// Data Layer — Takes JSON from the API service and returns a domain Entity.

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    final json = await _api.getWeather(city: city);
    return WeatherModel.fromJson(json);
  }
}
