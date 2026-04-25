import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_item_entity.dart';

// Data Layer — Model
// Extends or maps to the domain entity.
// In a real app, this handles JSON serialization/deserialization.

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.id,
    required super.name,
    required super.price,
    super.quantity,
  });

  // Factory to create from JSON (simulated)
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );
  }

  // Convert to JSON (simulated)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
