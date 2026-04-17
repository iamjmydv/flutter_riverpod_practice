import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_entity.dart';

// Data Layer — Model
// Extends or maps to the domain entity.
// In a real app, this handles JSON serialization/deserialization.

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.bio,
  });

  // Factory to create from JSON (simulated)
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
    );
  }

  // Convert to JSON (simulated)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
    };
  }
}
