import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/cart_item_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/change_notifier_provider_sample.dart';

// Sample products to add to cart
final sampleProducts = [
  CartItem(id: '1', name: 'Coffee', price: 4.99),
  CartItem(id: '2', name: 'Sandwich', price: 8.50),
  CartItem(id: '3', name: 'Cookie', price: 2.99),
];

class ChangeNotifierProviderPage extends ConsumerWidget {
  const ChangeNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(cartProvider) returns the CartNotifier OBJECT (not just the state).
    // The widget rebuilds whenever notifyListeners() is called inside CartNotifier.
    final cart = ref.watch(cartProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(cartProvider).clearCart(),
        child: const Icon(Icons.delete_outline),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Text(
              '* ChangeNotifierProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Shopping Cart',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Product list — tap to add to cart
            ...sampleProducts.map(
              (product) => ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () => ref.read(cartProvider).addItem(
                    CartItem(
                      id: product.id,
                      name: product.name,
                      price: product.price,
                    ),
                  ),
                ),
              ),
            ),

            const Divider(height: 32),

            // Cart summary
            Text(
              'Cart (${cart.totalItems} items)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Cart items
            Expanded(
              child: cart.items.isEmpty
                  ? const Center(child: Text('Cart is empty'))
                  : ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return ListTile(
                          title: Text('${item.name} x${item.quantity}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () =>
                                    ref.read(cartProvider).removeItem(item.id),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // Total
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KEY DIFFERENCE: ChangeNotifierProvider vs StateNotifierProvider
//
// ChangeNotifierProvider:
//   ref.watch(cartProvider)       → returns the CartNotifier OBJECT
//   ref.read(cartProvider).addItem(...)  → call methods directly
//   State is MUTABLE inside the notifier
//
// StateNotifierProvider:
//   ref.watch(counterProvider)           → returns the STATE (int)
//   ref.read(counterProvider.notifier)   → returns the notifier
//   State is IMMUTABLE (replaced, not mutated)
//
// To test: update main.dart to use ChangeNotifierProviderPage as the home widget.
