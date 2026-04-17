import 'package:riverpod_practice/eight_kinds_of_provider/7_NotifierProvider/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier is the MODERN replacement for StateNotifier (Riverpod 2.0+).
// It holds immutable state and exposes methods to replace it.
//
// Key differences from StateNotifier:
//   - Extends Notifier<T> instead of StateNotifier<T>
//   - Has a build() method instead of a constructor for initial state
//   - Has access to ref directly (no need to pass it via constructor)

class TodoNotifier extends Notifier<List<Todo>> {
  // build() replaces the constructor — returns the initial state
  @override
  List<Todo> build() {
    return [
      const Todo(id: '1', title: 'Buy groceries'),
      const Todo(id: '2', title: 'Walk the dog'),
      const Todo(id: '3', title: 'Read a book'),
    ];
  }

  void addTodo(String title) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    // Replace state with a new list (immutable update)
    state = [...state, newTodo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isCompleted: !todo.isCompleted)
        else todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
