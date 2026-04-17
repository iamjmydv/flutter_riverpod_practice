import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/data/user_profile_repository_impl.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/domain/user_profile_repository.dart';

// Application Layer — Repository Provider
// Typed as the ABSTRACT interface (UserProfileRepository)
// but creates the CONCRETE implementation (UserProfileRepositoryImpl).
// This is Dependency Inversion — swap implementations by changing one line.

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl();
});
