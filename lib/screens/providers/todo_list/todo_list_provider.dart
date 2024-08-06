import 'package:todo_riverpod_sync/models/todo_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<TodoModel> build() {
    return [
      const TodoModel(title: 'Learn Riverpod', completed: true, id: '1'),
      const TodoModel(title: 'Build a Todo App', completed: false, id: '2'),
      const TodoModel(title: 'Profit', completed: false, id: '3'),
    ];
  }

  void addTodo(String title) {
    state = [
      ...state,
      TodoModel.create(title: title),
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }

  void removeCompleted() {
    state = state.where((todo) => !todo.completed).toList();
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void editTodo(String id, String title) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(title: title);
      }
      return todo;
    }).toList();
  }
}
