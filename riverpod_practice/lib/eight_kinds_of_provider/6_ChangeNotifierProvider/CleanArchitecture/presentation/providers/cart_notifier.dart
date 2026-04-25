import 'package:flutter/foundation.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_item_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_repository.dart';

// Presentation Layer — ChangeNotifier
// Holds mutable cart state and pulls the product catalog from the repository.
// Depends on the abstract CartRepository, not the concrete implementation —
// the data source is injected by the provider.
//
// WARNING: Riverpod docs recommend Notifier/AsyncNotifier for new projects.
// ChangeNotifierProvider exists mainly for migrating from the Provider package.

class CartNotifier extends ChangeNotifier {
  CartNotifier(this._repository) {
    _loadProducts();
  }

  final CartRepository _repository;

  final List<CartItemEntity> _items = [];
  List<CartItemEntity> _availableProducts = [];
  bool _isLoading = true;

  // Public getters — UI watches these
  List<CartItemEntity> get items => List.unmodifiable(_items);
  List<CartItemEntity> get availableProducts =>
      List.unmodifiable(_availableProducts);
  bool get isLoading => _isLoading;

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  // Initial fetch from the repository
  Future<void> _loadProducts() async {
    _isLoading = true;
    notifyListeners();
    _availableProducts = await _repository.getAvailableProducts();
    _isLoading = false;
    notifyListeners();
  }

  void addItem(CartItemEntity product) {
    final index = _items.indexWhere((i) => i.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItemEntity(
          id: product.id,
          name: product.name,
          price: product.price,
        ),
      );
    }
    notifyListeners();
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
