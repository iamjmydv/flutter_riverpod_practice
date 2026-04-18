import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/city_entity.dart';

// Data Layer — City Model
//
// ── RAW JSON SAMPLE ──────────────────────────────────────────────────────────
//
//   {
//     "name": "London",
//     "country": "GB",
//     "latitude": 51.5073,
//     "longitude": -0.1276
//   }

class CityModel extends CityEntity {
  const CityModel({
    required super.name,
    required super.country,
    required super.latitude,
    required super.longitude,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
