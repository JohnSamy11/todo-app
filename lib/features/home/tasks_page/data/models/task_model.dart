import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app/extensions/time_of_day_extension.dart';
import 'package:todo_app/features/home/tasks_page/data/enums/tasks_page_enum.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final TimeOfDay time;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TimeOfDay? time,
    bool? completionState,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: completionState ?? this.isCompleted,
    );
  }

  Task get toggleCompletionState => copyWith(completionState: !isCompleted);

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, time: $time, completionState: $isCompleted}';
  }
}

extension TasksListExtension on List<Task> {
  List<Task> get sortByTimeOfDay =>
      [...this]..sort((a, b) => a.time.toDateTime.compareTo(b.time.toDateTime));

  List<Task> addAndSortByTimeOfDay(Task task) =>
      [...this, task]..sortByTimeOfDay;

  List<Task> getAllWithType(TasksPageType type) {
    switch (type) {
      case TasksPageType.undone:
        return [...this]..removeWhere((element) => element.isCompleted);
      case TasksPageType.done:
        return [...this]..removeWhere((element) => !element.isCompleted);
      case TasksPageType.all:
        return this;
    }
  }

  List<Task> getAllWithTypeAndSearch(TasksPageType type, String keyWord) {
    return [...getAllWithType(type)]..removeWhere(
        (element) =>
            !element.title.toLowerCase().contains(keyWord.toLowerCase()) &&
            !element.description.toLowerCase().contains(keyWord.toLowerCase()),
      );
  }

  List<Task> checkTask(Task task) {
    final list = [...this];
    var i = list.indexOf(task);
    return list..replaceRange(i, i + 1, [task.toggleCompletionState]);
  }
}
