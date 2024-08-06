import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_list/todo_list_provider.dart';

part 'active_todo_count.g.dart';

@riverpod
int activeTodoCount(ActiveTodoCountRef ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
}
