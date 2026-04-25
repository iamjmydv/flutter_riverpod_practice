import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/6_ChangeNotifierProvider/CleanArchitecture/presentation/providers/cart_provider.dart';

// Presentation Layer — Page (UI)
// Only knows about the application layer (providers).
// Has NO direct dependency on data or domain layers.

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
              'Shopping Cart (Clean Architecture)',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Product list — sourced from the repository through the notifier
            if (cart.isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )
            else
              ...cart.availableProducts.map(
                (product) => ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () =>
                        ref.read(cartProvider).addItem(product),
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

// CLEAN ARCHITECTURE SUMMARY:
//
// domain/                    → Entity + Abstract Repository (pure Dart, no dependencies)
// data/                      → Model (JSON) + Repository Implementation (API calls)
// presentation/providers/    → Repository provider, CartNotifier, ChangeNotifierProvider
// presentation/              → Page (UI widgets)
//
// Dependency rule: each layer only depends on the layers it should
//   presentation → domain ← data
//
// To swap the data source (e.g. fake → real API):
//   Just change CartRepositoryImpl in cart_repository_provider.dart
//   — the notifier and the UI never change.
//
// KEY DIFFERENCE: ChangeNotifierProvider vs StateNotifierProvider
//
// ChangeNotifierProvider:
//   ref.watch(cartProvider)              → returns the CartNotifier OBJECT
//   ref.read(cartProvider).addItem(...)  → call methods directly
//   State is MUTABLE inside the notifier
//
// StateNotifierProvider:
//   ref.watch(counterProvider)           → returns the STATE
//   ref.read(counterProvider.notifier)   → returns the notifier
//   State is IMMUTABLE (replaced, not mutated)
//
// To test: update main.dart to use this ChangeNotifierProviderPage as the home widget.
