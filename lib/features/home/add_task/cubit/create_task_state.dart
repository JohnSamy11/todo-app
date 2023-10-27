part of 'create_task_cubit.dart';

class CreateTaskState {
  final CreateTaskValidationResult validationResult;
  final TimeOfDay? time;
  final bool loading;

  const CreateTaskState({
    this.validationResult = const CreateTaskValidationResult(),
    this.time,
    this.loading = false,
  });

  CreateTaskState copyWith({
    CreateTaskValidationResult? validationResult,
    TimeOfDay? time,
    bool? loading,
  }) {
    return CreateTaskState(
      validationResult: validationResult ?? this.validationResult,
      time: time ?? this.time,
      loading: loading ?? this.loading,
    );
  }

  TimeOfDay get getTime => time ?? TimeOfDay.now();

  @override
  String toString() {
    return 'CreateTaskState{validationResult: $validationResult, time: $time, loading: $loading}';
  }
}
