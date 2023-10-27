import 'package:flutter/material.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/app/themes/app_theme.dart';
import 'package:todo_app/features/home/tasks_page/cubit/tasks_cubit.dart';
import 'package:todo_app/features/home/tasks_page/data/models/task_model.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final cubit = context.tasksCubitRead;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: theme.greyScale400.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style:
                TextStyle(fontSize: 30, color: theme.greyScale200, height: 1),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.title,
                  style: theme.textTheme.displayMedium!.copyWith(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  task.description,
                  style: theme.textTheme.bodySmall!.copyWith(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                task.time.format(context),
                style: theme.textTheme.bodySmall,
              ),
              Checkbox.adaptive(
                value: task.isCompleted,
                onChanged: (_) => cubit.checkTask(task),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
