import 'package:formz/formz.dart';

enum DateInputError { empty, inThePast }

class DateInput extends FormzInput<DateTime?, DateInputError> {
  const DateInput.pure() : super.pure(null);
  const DateInput.dirty(super.value) : super.dirty();

  @override
  DateInputError? validator(DateTime? value) {
    if (value == null) return DateInputError.empty;

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final selectedDate = DateTime(value.year, value.month, value.day);

    if (selectedDate.isBefore(todayDate)) return DateInputError.inThePast;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case DateInputError.empty:
        return 'La fecha es requerida';
      case DateInputError.inThePast:
        return 'No puedes seleccionar una fecha pasada';
      default:
        return null;
    }
  }
}
