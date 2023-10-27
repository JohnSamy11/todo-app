class CreateTaskValidationResult {
  final String? title;
  final String? description;
  final String? time;

  const CreateTaskValidationResult({
    this.title,
    this.description,
    this.time,
  });

  CreateTaskValidationResult copyWith({
    String? title,
    String? description,
    String? time,
  }) {
    return CreateTaskValidationResult(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  bool get hasError => firstErrorMessage != null;

  String? get firstErrorMessage => title ?? description ?? time?.toString();

  @override
  String toString() {
    return 'CreateTaskValidationResult{title: $title, description: $description, time: $time}';
  }
}
