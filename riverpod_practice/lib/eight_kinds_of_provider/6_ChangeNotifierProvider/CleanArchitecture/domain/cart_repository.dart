import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_item_entity.dart';

// Domain Layer — Repository Interface (Abstract)
// Defines WHAT the app can do, not HOW it does it.
// The data layer provides the concrete implementation.

abstract class CartRepository {
  // Returns the catalog of products that can be added to a cart.
  // In a real app this could come from a REST API, Firestore, GraphQL, etc.
  Future<List<CartItemEntity>> getAvailableProducts();
}
