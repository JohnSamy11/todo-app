enum TasksPageType {
  undone,
  done,
  all;

  bool get isUndone => this == undone;

  bool get isDone => this == done;

  bool get isAll => this == all;
}
