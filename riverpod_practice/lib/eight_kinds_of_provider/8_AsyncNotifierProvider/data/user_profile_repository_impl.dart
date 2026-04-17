import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/data/user_profile_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_repository.dart';

// Data Layer — Repository Implementation
// Concrete implementation of the domain's abstract repository.
// This is where the actual API calls, database queries, etc. happen.

class UserProfileRepositoryImpl implements UserProfileRepository {
  @override
  Future<UserProfile> fetchProfile() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real app: final response = await http.get('/api/profile');
    // Simulate a JSON response
    final fakeJson = {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'bio': 'Flutter developer',
    };

    return UserProfileModel.fromJson(fakeJson);
  }

  @override
  Future<UserProfile> updateProfile(UserProfile profile) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app: await http.put('/api/profile', body: model.toJson());
    return profile;
  }
}
