// Domain Layer — City Entity
// Represents a city returned from a search endpoint.

class CityEntity {
  final String name;
  final String country;
  final double latitude;
  final double longitude;

  const CityEntity({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => '$name, $country';
}
