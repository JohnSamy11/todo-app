part of 'tasks_cubit.dart';

class TasksState {
  final TasksPageType currentSelectedPageType;
  final bool isSearching;
  final String searchKeyWord;
  final List<Task> tasks;

  const TasksState({
    this.currentSelectedPageType = TasksPageType.undone,
    this.isSearching = false,
    this.searchKeyWord = '',
    this.tasks = const [],
  });

  TasksState copyWith({
    TasksPageType? currentSelectedPageType,
    bool? isSearching,
    String? searchKeyWord,
    List<Task>? tasks,
  }) {
    return TasksState(
      currentSelectedPageType:
          currentSelectedPageType ?? this.currentSelectedPageType,
      isSearching: isSearching ?? this.isSearching,
      searchKeyWord: searchKeyWord ?? this.searchKeyWord,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  String toString() {
    return 'TasksState{currentSelectedPageType: $currentSelectedPageType, isSearching: $isSearching, searchKeyWord: $searchKeyWord, tasks: $tasks}';
  }
}
