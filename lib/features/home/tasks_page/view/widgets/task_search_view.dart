import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/custom_widgets/custom_button.dart';
import 'package:todo_app/app/custom_widgets/custom_text_field.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/features/home/tasks_page/cubit/tasks_cubit.dart';
import 'package:todo_app/features/home/tasks_page/view/tasks_screen.dart';

class TaskSearchView extends StatelessWidget {
  const TaskSearchView({super.key});

  static const double buttonSearchStateWidth = 52;
  static const double paddingBetween = 10;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final availableWidth = context.widthPx - TasksScreen.horizontalPadding * 2;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        final cubit = context.tasksCubitRead;
        final isSearching = state.isSearching;
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            TasksScreen.horizontalPadding,
            20,
            TasksScreen.horizontalPadding,
            0,
          ),
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: buttonSearchStateWidth + paddingBetween),
                  child: AnimatedOpacity(
                    duration: 300.milliseconds,
                    curve: Curves.fastOutSlowIn,
                    opacity: isSearching ? 1 : 0,
                    child: CustomEditText(
                      borderRadius: 50,
                      enabled: isSearching,
                      focusNode: cubit.focusNode,
                      borderColor: theme.primaryColor,
                      controller: cubit.searchController,
                      onChanged: (_) => cubit.searchAction(true),
                      onFieldSubmitted: cubit.searchAction,
                      onTapOutside: cubit.searchAction,
                      textInputAction: TextInputAction.search,
                      formatters: [
                        LengthLimitingTextInputFormatter(50),
                        FilteringTextInputFormatter.deny(RegExp('^ ')),
                        FilteringTextInputFormatter.deny(RegExp('^\n')),
                      ],
                      trailing: state.searchKeyWord.isEmpty
                          ? null
                          : GestureDetector(
                              onTap: cubit.searchCloseAction,
                              child: Icon(
                                Icons.close_sharp,
                                color: theme.primaryColor,
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: CustomButton(
                    width:
                        isSearching ? buttonSearchStateWidth : availableWidth,
                    onPressed: cubit.searchButtonAction,
                    radius: 50,
                    gradient: LinearGradient(
                      colors: [
                        theme.primaryColor.withOpacity(.7),
                        theme.primaryColor,
                      ],
                    ),
                    text: isSearching ? null : 'Search',
                    textColor: theme.colorScheme.background,
                    icon: Icons.search_rounded,
                    iconColor: theme.colorScheme.background,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
