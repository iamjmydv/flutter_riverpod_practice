import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/8_AsyncNotifierProvider/application/user_profile_provider.dart';

// Presentation Layer — Page (UI)
// Only knows about the application layer (providers).
// Has NO direct dependency on data or domain layers.

class AsyncNotifierProviderPage extends ConsumerWidget {
  const AsyncNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() returns AsyncValue<UserProfile>
    // Same .when() pattern as FutureProvider and StreamProvider
    final profileAsync = ref.watch(userProfileProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Re-fetch the profile from scratch
          ref.invalidate(userProfileProvider);
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '* AsyncNotifierProvider *',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'User Profile (Clean Architecture)',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              profileAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
                data: (profile) => Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 40,
                      child: Text(
                        profile.name[0],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Name with edit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          profile.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () =>
                              _showEditDialog(context, ref, 'name', profile.name),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Email (read-only)
                    Text(
                      profile.email,
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // Bio with edit button
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              profile.bio,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () =>
                                _showEditDialog(context, ref, 'bio', profile.bio),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    String field,
    String currentValue,
  ) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newValue = controller.text.trim();
              if (newValue.isNotEmpty) {
                if (field == 'name') {
                  ref
                      .read(userProfileProvider.notifier)
                      .updateName(newValue);
                } else {
                  ref
                      .read(userProfileProvider.notifier)
                      .updateBio(newValue);
                }
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// CLEAN ARCHITECTURE SUMMARY:
//
// domain/   → Entity + Abstract Repository (pure Dart, no dependencies)
// data/     → Model (JSON) + Repository Implementation (API calls)
// application/ → Notifier (business logic) + Providers (glue)
// presentation/ → Page (UI widgets)
//
// Dependency rule: each layer only depends on the layer ABOVE it
//   presentation → application → domain ← data
//
// To swap the data source (e.g. fake → real API):
//   Just change UserProfileRepositoryImpl in the provider — nothing else changes.
//
// To test: update main.dart to use AsyncNotifierProviderPage as the home widget.
