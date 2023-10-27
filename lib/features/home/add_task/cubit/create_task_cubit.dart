// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:todo_app/app/extensions/context_extensions.dart';
import 'package:todo_app/features/home/add_task/data/models/create_task_validation_result.dart';
import 'package:todo_app/features/home/tasks_page/data/models/task_model.dart';
import 'package:uuid/uuid.dart';

part 'create_task_state.dart';

extension TasksCubitEx on BuildContext {
  CreateTaskCubit get createTaskCubitRead => read<CreateTaskCubit>();

  CreateTaskCubit get createTaskCubitWatch => watch<CreateTaskCubit>();
}

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this.context) : super(const CreateTaskState());

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }

  final BuildContext context;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void onDateTimeChanged(DateTime dateTime) {
    emit(state.copyWith(time: TimeOfDay.fromDateTime(dateTime)));
  }

  Future<void> pickTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: state.getTime,
    );
    if (timeOfDay != null) emit(state.copyWith(time: timeOfDay));
  }

  CreateTaskValidationResult validateData() {
    var result = const CreateTaskValidationResult();
    final name = titleController.text.trim();
    if (name.isEmpty) {
      result = result.copyWith(title: 'Task title required');
    }
    final des = descriptionController.text.trim();
    if (des.isEmpty) {
      result = result.copyWith(description: 'Task description required');
    }
    emit(state.copyWith(validationResult: result));
    return result;
  }

  Task _taskFromData() => Task(
        id: const Uuid().v1(),
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        time: state.getTime,
      );

  Future<void> saveTask() async {
    if (validateData().hasError) return;
    emit(state.copyWith(loading: true));
    await Future<void>.delayed(1.seconds);
    context.pop<Task>(_taskFromData());
  }
}
