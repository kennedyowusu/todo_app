import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_item/todo_item_provider.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_list/todo_list_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoItemProvider);
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            // return editTodo(ref, context);
            return EditTodoDialog(todo: todo);
          },
        );
      },
      leading: Checkbox(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.green;
          }
          return Colors.white;
        }),
        value: todo.completed,
        onChanged: (bool? checked) {
          ref.read(todoListProvider.notifier).toggleTodo(todo.id);
        },
      ),
      title: Text(todo.title),
      trailing: IconButton(
        onPressed: () async {
          final removeOrNot = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you really want to delete?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );

          if (removeOrNot) {
            ref.read(todoListProvider.notifier).removeTodo(todo.id);
          }
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }

  AlertDialog editTodo(WidgetRef ref, BuildContext context) {
    final todo = ref.watch(todoItemProvider);
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextFormField(
        controller: TextEditingController(text: todo.title),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (String value) {
          ref.read(todoListProvider.notifier).editTodo(todo.id, value);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class EditTodoDialog extends ConsumerStatefulWidget {
  final TodoModel todo;
  const EditTodoDialog({super.key, required this.todo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConfirmEditDialogState();
}

class _ConfirmEditDialogState extends ConsumerState<EditTodoDialog> {
  late final TextEditingController textController;
  bool error = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.todo.title);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextFormField(
        controller: textController,
        autofocus: true,
        decoration: InputDecoration(
          errorText: error ? 'Field cannot be empty' : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel Edit'),
        ),
        TextButton(
          onPressed: () {
            error = textController.text.isEmpty ? true : false;
            if (error) {
              setState(() {});
            } else {
              ref.read(todoListProvider.notifier).editTodo(
                    widget.todo.id,
                    textController.text,
                  );
              Navigator.pop(context);
            }
          },
          child: const Text('Update Todo'),
        ),
      ],
    );
  }
}
