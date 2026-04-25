import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/presentation/providers/cart_notifier.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/presentation/providers/cart_repository_provider.dart';

// Presentation Layer — ChangeNotifierProvider
// Wires the CartNotifier together with its CartRepository dependency.
//
// ref.watch(cartProvider) returns the CartNotifier OBJECT (not just the state).
// The widget rebuilds whenever notifyListeners() is called inside CartNotifier.

// Re-export so the page only needs one import
export 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/presentation/providers/cart_repository_provider.dart';

final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return CartNotifier(repository);
});

// ChangeNotifierProvider overview:
//
// 1. Create a class that extends ChangeNotifier
// 2. Mutate internal state and call notifyListeners()
// 3. Wrap it with ChangeNotifierProvider
// 4. ref.watch(cartProvider) returns the CartNotifier itself
//    (unlike StateNotifierProvider which returns the state)
//
// Clean Architecture benefit:
//   To swap the data source (e.g. fake → real API),
//   just change CartRepositoryImpl in cart_repository_provider.dart
//   — the notifier and the UI never change.
