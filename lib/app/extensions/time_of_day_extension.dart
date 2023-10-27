import 'package:flutter/material.dart';

extension TimeOfDayEx on TimeOfDay {
  DateTime get toDateTime {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }
}
