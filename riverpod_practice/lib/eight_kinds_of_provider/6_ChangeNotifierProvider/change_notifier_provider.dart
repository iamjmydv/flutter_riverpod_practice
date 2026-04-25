import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/cart_notifier.dart';

// ChangeNotifierProvider wraps a Flutter ChangeNotifier.
// It listens for notifyListeners() calls and rebuilds watchers.
//
// Real-world scenario: Shopping Cart
// - Mutable internal list of items
// - Methods to add, remove, clear
// - Computed properties (totalPrice, totalItems)

final cartProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});


// ChangeNotifierProvider overview:
//
// 1. Create a class that extends ChangeNotifier
// 2. Mutate internal state and call notifyListeners()
// 3. Wrap it with ChangeNotifierProvider
// 4. ref.watch(cartProvider) returns the CartNotifier itself
//    (unlike StateNotifierProvider which returns the state)
//
// Key difference from StateNotifierProvider:
//   StateNotifierProvider → ref.watch() returns the STATE
//   ChangeNotifierProvider → ref.watch() returns the NOTIFIER object
//
// When to use:
//   - Migrating from the Provider package
//   - When you need mutable state with notifyListeners()
//
// When NOT to use (prefer Notifier instead):
//   - New projects — ChangeNotifier is less predictable because
//     state is mutable and changes aren't tracked immutably
