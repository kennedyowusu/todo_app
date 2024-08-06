import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/providers/active_todo_count/active_todo_count.dart';
import 'package:todo_riverpod_sync/screens/providers/app_theme/app_theme_provider.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_list/todo_list_provider.dart';

class TopSection extends ConsumerWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int activeTodoCount = ref.watch(activeTodoCountProvider);
    final List<TodoModel> allTodos = ref.watch(todoListProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Todo'),
        const SizedBox(
          width: 10,
        ),
        Text(
          "$activeTodoCount of ${allTodos.length} remaining",
          style: const TextStyle(color: Colors.grey),
        ),
        IconButton(
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
          icon: const Icon(Icons.sunny),
        )
      ],
    );
  }
}
