import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/7_NotifierProvider/notifier_provider_sample.dart';

class NotifierProviderPage extends ConsumerWidget {
  const NotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() returns the STATE — List<Todo>
    final todos = ref.watch(todoNotifierProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 48),
            const Text(
              '* NotifierProvider *',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Todo List (${todos.where((t) => t.isCompleted).length}/${todos.length} done)',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text('No todos yet. Tap + to add one.'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) => ref
                                .read(todoNotifierProvider.notifier)
                                .toggleTodo(todo.id),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color:
                                  todo.isCompleted ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () => ref
                                .read(todoNotifierProvider.notifier)
                                .removeTodo(todo.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'What needs to be done?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref
                    .read(todoNotifierProvider.notifier)
                    .addTodo(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// KEY DIFFERENCE: NotifierProvider vs StateNotifierProvider
//
// StateNotifierProvider (legacy):
//   class MyNotifier extends StateNotifier<int> {
//     MyNotifier() : super(0);           // initial state in constructor
//   }
//
// NotifierProvider (modern):
//   class MyNotifier extends Notifier<int> {
//     @override
//     int build() => 0;                  // initial state in build()
//   }
//
// Both use:
//   ref.watch(provider)           → returns the STATE
//   ref.read(provider.notifier)   → returns the NOTIFIER
//
// To test: update main.dart to use NotifierProviderPage as the home widget.
