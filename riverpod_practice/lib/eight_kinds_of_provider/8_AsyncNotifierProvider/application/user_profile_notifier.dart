import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/application/user_profile_repository_provider.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_entity.dart';

// Application Layer — AsyncNotifier (Business Logic)
// Orchestrates data fetching and state mutations.
// Talks to the domain layer via the repository interface.
//
// AsyncNotifier is the MODERN replacement for FutureProvider + StateNotifier.
// Key advantages:
//   - build() is async → perfect for initial data fetching
//   - Has access to ref → can watch other providers
//   - State is AsyncValue<T> → loading/error/data built in
//   - Can define methods to update state after fetching

class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  // build() is async — fetches the initial data
  @override
  Future<UserProfile> build() async {
    final repository = ref.watch(userProfileRepositoryProvider);
    return repository.fetchProfile();
  }

  // Update the user's name — shows loading while saving
  Future<void> updateName(String newName) async {
    final repository = ref.read(userProfileRepositoryProvider);

    final currentProfile = state.value;
    if (currentProfile == null) return;

    // Set loading state while updating
    state = const AsyncLoading();

    // AsyncValue.guard: returns AsyncData on success, AsyncError on failure
    state = await AsyncValue.guard(() {
      final updated = currentProfile.copyWith(name: newName);
      return repository.updateProfile(updated);
    });
  }

  // Update the bio
  Future<void> updateBio(String newBio) async {
    final repository = ref.read(userProfileRepositoryProvider);

    final currentProfile = state.value;
    if (currentProfile == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      final updated = currentProfile.copyWith(bio: newBio);
      return repository.updateProfile(updated);
    });
  }
}
