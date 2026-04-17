import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_entity.dart';

// Domain Layer — Repository Interface (Abstract)
// Defines WHAT the app can do, not HOW it does it.
// The data layer provides the concrete implementation.

abstract class UserProfileRepository {
  Future<UserProfile> fetchProfile();
  Future<UserProfile> updateProfile(UserProfile profile);
}
