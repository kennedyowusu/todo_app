import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_list/todo_list_provider.dart';

class AddNewTodo extends ConsumerStatefulWidget {
  const AddNewTodo({super.key});

  @override
  ConsumerState<AddNewTodo> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends ConsumerState<AddNewTodo> {
  final TextEditingController todoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: todoEditingController,
      decoration: InputDecoration(
        hintText: 'What needs to be done?',
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty || value.trim().isEmpty) {
          return 'Please enter a valid todo';
        }
        return null;
      },
      onFieldSubmitted: (String newTodo) {
        if (newTodo.isNotEmpty && newTodo.trim().isNotEmpty) {
          ref.read(todoListProvider.notifier).addTodo(newTodo);
          todoEditingController.clear();
        }
      },
    );
  }
}
