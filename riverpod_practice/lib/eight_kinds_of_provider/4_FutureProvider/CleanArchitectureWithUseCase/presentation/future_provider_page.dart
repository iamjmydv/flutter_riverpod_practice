import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/future_providers.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/4_FutureProvider/CleanArchitectureWithUseCase/application/usecase_providers.dart';

// Presentation Layer — Page (UI)
// Only knows about the application layer (providers + use case providers).
// Has NO direct dependency on data or domain repository/model classes.
//
// This page demonstrates all HTTP verbs through the use cases:
//   GET    → current weather, forecast, favorites list
//   POST   → add a favorite
//   PUT    → edit a favorite
//   DELETE → remove a favorite

class FutureProviderPage extends ConsumerWidget {
  const FutureProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Three independent AsyncValue streams, one per FutureProvider.
    final weatherAsync = ref.watch(weatherFutureProvider);
    final forecastAsync = ref.watch(forecastFutureProvider);
    final favoritesAsync = ref.watch(favoriteCitiesFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Re-fetch all three read endpoints.
              ref.invalidate(weatherFutureProvider);
              ref.invalidate(forecastFutureProvider);
              ref.invalidate(favoriteCitiesFutureProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddFavoriteDialog(context, ref),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Current Weather (GET)'),
          _weatherCard(weatherAsync),
          const SizedBox(height: 24),

          _sectionTitle('3-Day Forecast (GET)'),
          _forecastCard(forecastAsync),
          const SizedBox(height: 24),

          _sectionTitle('Favorite Cities (GET / POST / PUT / DELETE)'),
          _favoritesCard(context, ref, favoritesAsync),
        ],
      ),
    );
  }

  // ── Section widgets ────────────────────────────────────────────────────────

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );

  Widget _weatherCard(AsyncValue weatherAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: weatherAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err',
              style: const TextStyle(color: Colors.red)),
          data: (weather) => Row(
            children: [
              const Icon(Icons.wb_sunny, size: 48, color: Colors.orange),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weather.city,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('${weather.temperature}°C — ${weather.condition}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forecastCard(AsyncValue forecastAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: forecastAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err',
              style: const TextStyle(color: Colors.red)),
          data: (forecast) => Column(
            children: forecast.days.map<Widget>((d) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        d.date.toIso8601String().split('T').first,
                      ),
                    ),
                    Text('${d.minTemp}° / ${d.maxTemp}°'),
                    const SizedBox(width: 12),
                    Text(d.condition,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _favoritesCard(
    BuildContext context,
    WidgetRef ref,
    AsyncValue favoritesAsync,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: favoritesAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Error: $err',
                style: const TextStyle(color: Colors.red)),
          ),
          data: (favorites) {
            if (favorites.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No favorites yet. Tap + to add one.'),
              );
            }
            return Column(
              children: favorites.map<Widget>((fav) {
                return ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: Text(fav.city),
                  subtitle: Text('id: ${fav.id}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showEditFavoriteDialog(
                            context, ref, fav.id, fav.city),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeFavorite(context, ref, fav.id),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  // ── Write actions (POST / PUT / DELETE) ───────────────────────────────────
  //
  // These are imperative — they run on a button tap, they don't live
  // inside a FutureProvider. The pattern:
  //   1. ref.read(useCaseProvider) → the use case instance
  //   2. await it with the form input
  //   3. ref.invalidate(listProvider) → re-fetch to reflect the change

  Future<void> _showAddFavoriteDialog(
      BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Favorite City'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'e.g. Tokyo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result == null || result.isEmpty) return;

    try {
      // POST /v1/favorites
      final addFavorite = ref.read(addFavoriteCityUseCaseProvider);
      await addFavorite(city: result);
      ref.invalidate(favoriteCitiesFutureProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _showEditFavoriteDialog(
    BuildContext context,
    WidgetRef ref,
    String id,
    String currentCity,
  ) async {
    final controller = TextEditingController(text: currentCity);
    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Favorite'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result == null || result.isEmpty) return;

    try {
      // PUT /v1/favorites/{id}
      final updateFavorite = ref.read(updateFavoriteCityUseCaseProvider);
      await updateFavorite(id: id, city: result);
      ref.invalidate(favoriteCitiesFutureProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  Future<void> _removeFavorite(
      BuildContext context, WidgetRef ref, String id) async {
    try {
      // DELETE /v1/favorites/{id}
      final removeFavorite = ref.read(removeFavoriteCityUseCaseProvider);
      await removeFavorite(id: id);
      ref.invalidate(favoriteCitiesFutureProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }
}
