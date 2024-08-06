import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:todo_riverpod_sync/screens/providers/todo_filter/todo_filter_provider.dart';

class FilterButton extends ConsumerWidget {
  const FilterButton({super.key, required this.filter});

  final VisibilityFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VisibilityFilter selectedFilter = ref.watch(todoFilterProvider);
    return TextButton(
      onPressed: () {
        ref.read(todoFilterProvider.notifier).changeFilter(filter);
      },
      child: Text(
        filter == VisibilityFilter.all
            ? 'All'
            : filter == VisibilityFilter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          color: filter == selectedFilter
              ? Colors.blue
              : Colors.black.withAlpha(150),
        ),
      ),
    );
  }
}
