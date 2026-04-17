import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/7_NotifierProvider/todo_model.dart';
import 'package:riverpod_practice/eight_kinds_of_provider/7_NotifierProvider/todo_notifier.dart';

// NotifierProvider is the MODERN way to manage synchronous state in Riverpod 2.0+.
// It replaces StateNotifierProvider.
//
// Real-world scenario: Todo List
// - Immutable state (List<Todo>)
// - Named methods to add, toggle, remove
// - build() provides initial state

final todoNotifierProvider =
    NotifierProvider<TodoNotifier, List<Todo>>(() {
  return TodoNotifier();
});


// NotifierProvider overview:
//
// 1. Create a class that extends Notifier<T>
// 2. Override build() to return the initial state
// 3. Modify state by reassigning this.state (immutable updates)
// 4. Wrap it with NotifierProvider
//
// ref.watch(todoNotifierProvider)          → returns List<Todo> (the STATE)
// ref.read(todoNotifierProvider.notifier)  → returns TodoNotifier (the NOTIFIER)
//
// Why Notifier over StateNotifier?
//   - build() is cleaner than constructor for initial state
//   - Has direct access to ref (can watch other providers)
//   - Part of the new Riverpod 2.0 API
//   - StateNotifier is now considered legacy
