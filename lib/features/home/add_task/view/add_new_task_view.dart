import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/custom_widgets/custom_button.dart';
import 'package:todo_app/app/custom_widgets/custom_loading.dart';
import 'package:todo_app/app/custom_widgets/custom_text_field.dart';
import 'package:todo_app/app/extensions/bottom_sheet_extension.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/app/extensions/time_of_day_extension.dart';
import 'package:todo_app/features/home/add_task/cubit/create_task_cubit.dart';
import 'package:todo_app/features/home/add_task/view/widgets/add_task_input_widget.dart';
import 'package:todo_app/features/home/tasks_page/data/models/task_model.dart';

class AddNewTaskView extends StatelessWidget {
  const AddNewTaskView({super.key});

  static Future<Task?> showAddNewTaskBottomSheet(BuildContext context) async {
    return await context.showCustomBottomSheet<Task?>(
      widget: const AddNewTaskView(),
      safeArea: true,
      withBlur: true,
      padding: 20,
    );
  }

  static const double iconButtonDimensions = 35;

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocProvider(
      create: CreateTaskCubit.new,
      child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
        builder: (context, state) {
          final cubit = context.createTaskCubitRead;
          return Material(
            borderRadius: BorderRadius.circular(25),
            color: theme.colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: iconButtonDimensions),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Add New Task',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.displayMedium,
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: context.pop,
                        height: iconButtonDimensions,
                        width: iconButtonDimensions,
                        radius: 50,
                        contentPadding: 0,
                        icon: Icons.close_sharp,
                        iconSize: 25,
                        borderColor: theme.primaryColor,
                        iconColor: theme.primaryColor,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 30,
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.only(bottom: context.viewInsets.bottom),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //title
                          AddTaskInputWidget(
                            title: 'Title',
                            errorMessage: state.validationResult.title,
                            child: CustomEditText(
                              enabled: !state.loading,
                              controller: cubit.titleController,
                              textCapitalization: TextCapitalization.words,
                              formatters: [
                                LengthLimitingTextInputFormatter(20),
                                FilteringTextInputFormatter.deny(RegExp('^ ')),
                              ],
                            ),
                          ),
                          //description
                          AddTaskInputWidget(
                            title: 'Description',
                            errorMessage: state.validationResult.description,
                            child: CustomEditText(
                              maxLines: 3,
                              enabled: !state.loading,
                              controller: cubit.descriptionController,
                              textInputAction: TextInputAction.newline,
                              textCapitalization: TextCapitalization.sentences,
                              formatters: [
                                LengthLimitingTextInputFormatter(50),
                                FilteringTextInputFormatter.deny(RegExp('^ ')),
                                FilteringTextInputFormatter.deny(RegExp('^\n')),
                              ],
                            ),
                          ),
                          //time
                          AddTaskInputWidget(
                            title: 'Time',
                            errorMessage: state.validationResult.time,
                            child: Platform.isIOS
                                ? SizedBox(
                                    height: 100,
                                    child: CupertinoDatePicker(
                                      initialDateTime: state.getTime.toDateTime,
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged:
                                          cubit.onDateTimeChanged,
                                    ),
                                  )
                                : CustomButton(
                                    onPressed: cubit.pickTime,
                                    text: state.getTime.format(context),
                                    textSize: 26,
                                    borderColor: theme.primaryColor,
                                    textColor: theme.primaryColor,
                                  ),
                          ),
                          //confirm Button
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomButton(
                              onPressed: state.loading ? null : cubit.saveTask,
                              radius: 100,
                              text: state.loading ? null : 'Add Task',
                              textColor: theme.colorScheme.background,
                              color: theme.primaryColor,
                              child: state.loading
                                  ? CustomLoading(
                                      color: theme.colorScheme.background,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
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
