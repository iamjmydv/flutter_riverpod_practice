// Domain Layer — Favorite City Entity
// Represents a user's saved favorite. Has a server-assigned ID.

class FavoriteCityEntity {
  final String id;
  final String city;
  final DateTime createdAt;

  const FavoriteCityEntity({
    required this.id,
    required this.city,
    required this.createdAt,
  });
}
