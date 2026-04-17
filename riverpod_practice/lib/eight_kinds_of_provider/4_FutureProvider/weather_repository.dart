import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/weather_model.dart';

// A repository that simulates fetching weather data from an API

class WeatherRepository {
  Future<Weather> getWeather({required String city}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));
    // Return fake weather data
    return Weather(city: city, temperature: 22.5, condition: 'Sunny');
  }
}
