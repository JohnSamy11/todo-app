import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/app/themes/app_theme.dart';
import 'package:todo_app/features/home/add_task/view/widgets/add_new_task_button.dart';
import 'package:todo_app/features/home/tasks_page/cubit/tasks_cubit.dart';
import 'package:todo_app/features/home/tasks_page/data/enums/tasks_page_enum.dart';
import 'package:todo_app/features/home/tasks_page/view/widgets/task_list_item.dart';
import 'package:todo_app/features/home/tasks_page/view/widgets/task_search_view.dart';
import 'package:todo_app/features/home/tasks_page/view/widgets/tast_tap_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  static const double horizontalPadding = 20;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: TasksCubit.new,
      child: Builder(
        builder: (context) {
          return const Scaffold(
            body: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        _ScreenHeader(),
                        _ScreenContent(),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    right: 5,
                    child: AddTaskButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          TasksScreen.horizontalPadding, 20, TasksScreen.horizontalPadding, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: theme.textTheme.displayLarge!.copyWith(fontSize: 26),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('dd MMM yyyy, EEEE').format(DateTime.now()),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            Icons.calendar_today_outlined,
            color: theme.greyScale400,
          ),
        ],
      ),
    );
  }
}

class _ScreenContent extends StatelessWidget {
  const _ScreenContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          final cubit = context.tasksCubitRead;
          final currentSelectedPageType = state.currentSelectedPageType;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TaskSearchView(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  TasksScreen.horizontalPadding,
                  20,
                  TasksScreen.horizontalPadding,
                  0,
                ),
                height: 40,
                child: Row(
                  children: [
                    for (final type in TasksPageType.values) ...[
                      TasksTapButton(
                        pageType: type,
                        currentSelectedPageType: currentSelectedPageType,
                      ),
                      if (type != TasksPageType.values.last)
                        const SizedBox(width: 20),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  controller: cubit.pageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: cubit.onPageChange,
                  itemCount: TasksPageType.values.length,
                  itemBuilder: (context, index) {
                    final list =
                        cubit.getTasksListByType(TasksPageType.values[index]);
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        10,
                        20,
                        AddTaskButton.buttonHeight,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ToDoListItem(
                          task: list[index],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
