import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:todo_app/app/custom_widgets/custom_button.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/features/home/tasks_page/cubit/tasks_cubit.dart';
import 'package:todo_app/features/home/tasks_page/data/enums/tasks_page_enum.dart';

class TasksTapButton extends StatelessWidget {
  const TasksTapButton({
    super.key,
    required this.pageType,
    required this.currentSelectedPageType,
  });

  final TasksPageType pageType;
  final TasksPageType currentSelectedPageType;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final isSelected = pageType == currentSelectedPageType;
    final cubit = context.tasksCubitRead;
    final count =
        pageType.isUndone ? cubit.getTasksListByType(pageType).length : 0;
    return Expanded(
      child: CustomButton(
        onPressed: () => context.tasksCubitRead.selectTasksType(pageType),
        radius: 50,
        borderLess: true,
        contentPadding: 0,
        text: pageType.name.capitalize,
        textColor: isSelected ? theme.primaryColor : null,
        color: isSelected ? theme.primaryColor.withOpacity(.2) : null,
        textStyle: theme.textTheme.displayMedium!.copyWith(
          color: isSelected ? theme.primaryColor : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(pageType.name.capitalize ?? ''),
              ),
              if (count == 0)
                const SizedBox(width: 15)
              else
                Align(
                  heightFactor: .5,
                  child: Container(
                    width: 15,
                    height: 15,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: FittedBox(
                      alignment: Alignment.center,
                      child: Text(
                        count.toString(),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
