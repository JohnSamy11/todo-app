import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:todo_app/features/home/add_task/view/add_new_task_view.dart';
import 'package:todo_app/features/home/tasks_page/data/enums/tasks_page_enum.dart';
import 'package:todo_app/features/home/tasks_page/data/models/task_model.dart';

part 'tasks_state.dart';

extension TasksCubitEx on BuildContext {
  TasksCubit get tasksCubitRead => read<TasksCubit>();

  TasksCubit get tasksCubitWatch => watch<TasksCubit>();
}

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this.context) : super(const TasksState());

  @override
  Future<void> close() {
    focusNode.dispose();
    searchController.dispose();
    pageController.dispose();
    return super.close();
  }

  final BuildContext context;
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final PageController pageController = PageController();

  var _animatingPages = false;

  //for taps navigation
  Future<void> selectTasksType(TasksPageType type,
      {bool fromSwipe = false}) async {
    emit(state.copyWith(currentSelectedPageType: type));
    if (fromSwipe) return;
    _animatingPages = true;
    await pageController.animateToPage(
      TasksPageType.values.indexOf(type),
      duration: 300.milliseconds,
      curve: Curves.fastOutSlowIn,
    );
    _animatingPages = false;
  }

  void onPageChange(int page) {
    if (_animatingPages) return;
    selectTasksType(TasksPageType.values[page], fromSwipe: true);
  }

  //for viewing tasks
  List<Task> getTasksListByType(TasksPageType type) => state.isSearching
      ? state.tasks.getAllWithTypeAndSearch(type, state.searchKeyWord)
      : state.tasks.getAllWithType(type);

  //for searching
  void searchAction(dynamic changing) {
    if (!state.isSearching) return;
    if (searchController.text.trim().isEmpty &&
        (changing is bool ? !changing : true)) {
      _endSearch();
    } else {
      _doSearch();
    }
  }

  void searchButtonAction() {
    if (closingSearch) return;
    if (!state.isSearching) {
      _beginSearch();
    } else {
      focusNode.unfocus();
    }
  }

  void searchCloseAction() {
    searchController.clear();
    _doSearch();
    searchAction('');
  }

  void _doSearch() {
    final keyWord = searchController.text.trim();
    emit(state.copyWith(searchKeyWord: keyWord));
  }

  Future<void> _beginSearch() async {
    emit(state.copyWith(isSearching: true));
    await Future<void>.delayed(100.milliseconds);
    focusNode.requestFocus();
  }

  bool closingSearch = false;

  Future<void> _endSearch() async {
    emit(state.copyWith(isSearching: false));
    closingSearch = true;
    await Future<void>.delayed(300.milliseconds);
    closingSearch = false;
  }

  // for adding tasks
  Future<void> addNewTask() async {
    final task = await AddNewTaskView.showAddNewTaskBottomSheet(context);
    if (task == null) return;
    final list = [...state.tasks, task];
    emit(state.copyWith(tasks: list.sortByTimeOfDay));
  }

  //for checking tasks
  void checkTask(Task task) {
    emit(state.copyWith(tasks: state.tasks.checkTask(task)));
  }
}
