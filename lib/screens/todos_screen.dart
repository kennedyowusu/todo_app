import 'package:flutter/material.dart';
import 'package:todo_riverpod_sync/screens/widgets/filter_todo.dart';
import 'package:todo_riverpod_sync/screens/widgets/new_todo.dart';
import 'package:todo_riverpod_sync/screens/widgets/search_todo.dart';
import 'package:todo_riverpod_sync/screens/widgets/show_todo.dart';
import 'package:todo_riverpod_sync/screens/widgets/top_section.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TopSection(),
              SizedBox(height: 20),
              AddNewTodo(),
              SizedBox(height: 20),
              SearchTodo(),
              SizedBox(height: 20),
              FilterTodo(),
              SizedBox(height: 10),
              Expanded(child: ShowTodos()),
            ],
          ),
        ),
      ),
    );
  }
}
