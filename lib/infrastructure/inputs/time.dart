import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

enum TimeInputError { empty }

class TimeInput extends FormzInput<TimeOfDay?, TimeInputError> {
  const TimeInput.pure() : super.pure(null);
  const TimeInput.dirty(super.value) : super.dirty();

  @override
  TimeInputError? validator(TimeOfDay? value) {
    if (value == null) return TimeInputError.empty;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case TimeInputError.empty:
        return 'La hora es requerida';
      default:
        return null;
    }
  }
}
