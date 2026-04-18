import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/domain/favorite_city_entity.dart';

// Data Layer — Favorite City Model
//
// ── RAW JSON SAMPLE ──────────────────────────────────────────────────────────
//
//   {
//     "id": "fav_01HXYZ123ABC",
//     "city": "London",
//     "created_at": "2026-04-10T10:00:00Z"
//   }
//
// ── OUTBOUND JSON (POST / PUT body) ──────────────────────────────────────────
//
//   { "city": "London" }
//
// The server assigns `id` and `created_at`; the client only sends `city`.

class FavoriteCityModel extends FavoriteCityEntity {
  const FavoriteCityModel({
    required super.id,
    required super.city,
    required super.createdAt,
  });

  factory FavoriteCityModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCityModel(
      id: json['id'] as String,
      city: json['city'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // Body used for POST / PUT — only the editable fields.
  Map<String, dynamic> toJson() {
    return {'city': city};
  }
}
