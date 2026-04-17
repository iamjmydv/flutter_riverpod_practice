import 'package:flutter/foundation.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/cart_item_model.dart';

// ChangeNotifier from Flutter — mutates internal state and calls notifyListeners().
// This is the same pattern used by Provider (the package), so it's familiar to many.
//
// WARNING: Riverpod docs recommend using Notifier/AsyncNotifier instead.
// ChangeNotifierProvider exists mainly for migrating from Provider package.

class CartNotifier extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CartItem item) {
    // If item already in cart, increase quantity
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }
    notifyListeners(); // Tell Riverpod to rebuild watchers
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
