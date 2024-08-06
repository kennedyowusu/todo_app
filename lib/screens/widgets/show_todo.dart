import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/providers/filtered_todos/filtered_todos_provider.dart';
import 'package:todo_riverpod_sync/screens/widgets/todo_item.dart';

import '../providers/todo_item/todo_item_provider.dart';

class ShowTodos extends ConsumerWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TodoModel> filterTodo = ref.watch(filteredTodoProvider);

    return ListView.separated(
      itemCount: filterTodo.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.grey);
      },
      itemBuilder: (BuildContext context, int index) {
        final TodoModel todo = filterTodo[index];
        return ProviderScope(
          overrides: [
            todoItemProvider.overrideWithValue(todo),
          ],
          child: const TodoItem(),
        );
      },
    );
  }
}
