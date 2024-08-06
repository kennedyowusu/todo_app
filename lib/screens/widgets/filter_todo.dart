import 'package:flutter/material.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/widgets/filter_button.dart';

class FilterTodo extends StatelessWidget {
  const FilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterButton(filter: VisibilityFilter.all),
        FilterButton(filter: VisibilityFilter.active),
        FilterButton(filter: VisibilityFilter.completed),
      ],
    );
  }
}
