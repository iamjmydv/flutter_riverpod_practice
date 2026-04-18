import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/data/weather_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/domain/weather_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitecture/domain/weather_repository.dart';

// Data Layer — Repository Implementation
// Concrete implementation of the domain's abstract repository.
// This is where the actual API calls, database queries, etc. happen.

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<WeatherEntity> getWeather({required String city}) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app: final response = await http.get('/api/weather?city=$city');
    // Simulate a JSON response
    final fakeJson = {
      'city': city,
      'temperature': 22.5,
      'condition': 'Sunny',
    };

    return WeatherModel.fromJson(fakeJson);
  }
}
