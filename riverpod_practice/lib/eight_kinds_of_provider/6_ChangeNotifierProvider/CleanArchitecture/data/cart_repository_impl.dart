import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/data/cart_item_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_item_entity.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/domain/cart_repository.dart';

// Data Layer — Repository Implementation
// Concrete implementation of the domain's abstract repository.
// This is where the actual API calls, database queries, etc. happen.

class CartRepositoryImpl implements CartRepository {
  @override
  Future<List<CartItemEntity>> getAvailableProducts() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app: final response = await http.get('/api/products');
    // Simulate a JSON response
    final fakeJson = [
      {'id': '1', 'name': 'Coffee', 'price': 4.99},
      {'id': '2', 'name': 'Sandwich', 'price': 8.50},
      {'id': '3', 'name': 'Cookie', 'price': 2.99},
    ];

    return fakeJson.map(CartItemModel.fromJson).toList();
  }
}
