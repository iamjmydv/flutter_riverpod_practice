// Domain Layer — Entity
// Pure Dart class with no dependencies on Flutter, Riverpod, or any package.
// Represents the core business object.

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String bio;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
  });

  UserProfile copyWith({String? name, String? email, String? bio}) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }
}
