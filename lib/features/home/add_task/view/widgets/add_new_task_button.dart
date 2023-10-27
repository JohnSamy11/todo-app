import 'package:flutter/material.dart';
import 'package:todo_app/app/custom_widgets/custom_button.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/features/home/tasks_page/cubit/tasks_cubit.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  static const double buttonHeight = 80;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final tasksCubit = context.tasksCubitRead;
    return CustomButton(
      onPressed: tasksCubit.addNewTask,
      color: theme.primaryColor,
      height: buttonHeight,
      radius: 100,
      text: 'Add new task',
      textColor: theme.colorScheme.background,
      icon: Icons.add_circle,
      iconColor: theme.colorScheme.background,
    );
  }
}
