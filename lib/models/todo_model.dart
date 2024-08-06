import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.freezed.dart';

Uuid _uuid = const Uuid();

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    required bool completed,
  }) = _TodoModel;

  factory TodoModel.create({required String title}) {
    return TodoModel(
      id: _uuid.v4(),
      title: title,
      completed: false,
    );
  }
}

enum VisibilityFilter { all, active, completed }
