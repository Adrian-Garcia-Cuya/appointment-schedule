import 'package:formz/formz.dart';

enum DescriptionInputError { tooLong }

class DescriptionInput extends FormzInput<String, DescriptionInputError> {
  const DescriptionInput.pure() : super.pure('');
  const DescriptionInput.dirty(super.value) : super.dirty();

  @override
  DescriptionInputError? validator(String value) {
    final text = value.trim();

    if (text.isEmpty) return null;

    if (text.length > 500) return DescriptionInputError.tooLong;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case DescriptionInputError.tooLong:
        return 'La descripción no puede exceder los 500 caracteres';
      default:
        return null;
    }
  }
}
