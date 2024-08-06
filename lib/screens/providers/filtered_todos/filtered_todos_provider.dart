import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_search/todo_search_provider.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_filter/todo_filter_provider.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_list/todo_list_provider.dart';

part 'filtered_todos_provider.g.dart';

@riverpod
List<TodoModel> filteredTodo(FilteredTodoRef ref) {
  final List<TodoModel> todos = ref.watch(todoListProvider);
  final VisibilityFilter filter = ref.watch(todoFilterProvider);
  final String search = ref.watch(todoSearchProvider);

  List<TodoModel> tempTodos;

  tempTodos = switch (filter) {
    VisibilityFilter.active => todos.where((todo) => !todo.completed).toList(),
    VisibilityFilter.completed =>
      todos.where((todo) => todo.completed).toList(),
    VisibilityFilter.all => todos,
  };

  if (search.isNotEmpty) {
    return tempTodos.where((todo) => todo.title.contains(search)).toList();
  }

  return tempTodos;
}
