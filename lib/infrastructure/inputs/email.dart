import 'package:formz/formz.dart';

enum EmailInputError { empty, invalidFormat }

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty(super.value) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  @override
  EmailInputError? validator(String value) {
    final text = value.trim();

    if (text.isEmpty) return EmailInputError.empty;
    if (!_emailRegExp.hasMatch(text)) return EmailInputError.invalidFormat;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case EmailInputError.empty:
        return 'El correo electrónico es requerido';
      case EmailInputError.invalidFormat:
        return 'Ingresa un correo electrónico válido';
      default:
        return null;
    }
  }
}
