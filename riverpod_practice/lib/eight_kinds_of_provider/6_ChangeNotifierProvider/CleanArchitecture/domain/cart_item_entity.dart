// Domain Layer — Entity
// Pure Dart class with no dependencies on Flutter, Riverpod, or any package.
// Represents the core business object — a product line in the cart.

class CartItemEntity {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItemEntity({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  @override
  String toString() => '$name x$quantity (\$${price.toStringAsFixed(2)})';
}
