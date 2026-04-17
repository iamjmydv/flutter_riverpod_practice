import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/application/user_profile_notifier.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_entity.dart';

// Application Layer — Providers
// All providers live here. This is the glue between layers.
//
// Repository provider lives in user_profile_repository_provider.dart
// to avoid circular imports (notifier needs it, and this file needs the notifier).

// Re-export so the presentation layer only needs one import
export 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/application/user_profile_repository_provider.dart';

// AsyncNotifierProvider — the state is AsyncValue<UserProfile>
final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile>(() {
  return UserProfileNotifier();
});


// AsyncNotifierProvider overview:
//
// 1. Create a class that extends AsyncNotifier<T>
// 2. Override build() as a Future<T> — this fetches initial data
// 3. State type is automatically AsyncValue<T> (loading, error, data)
// 4. Define async methods to update state after initial load
//
// ref.watch(userProfileProvider)          → AsyncValue<UserProfile>
// ref.read(userProfileProvider.notifier)  → UserProfileNotifier
//
// Clean Architecture benefit:
//   To swap from fake API to real API, just change UserProfileRepositoryImpl
//   in the provider above — no other file needs to change.
