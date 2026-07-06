import 'package:formz/formz.dart';

enum TitleInputError { empty, tooShort, tooLong }

class TitleInput extends FormzInput<String, TitleInputError> {
  const TitleInput.pure() : super.pure('');
  const TitleInput.dirty(super.value) : super.dirty();

  @override
  TitleInputError? validator(String value) {
    final text = value.trim();

    if (text.isEmpty) return TitleInputError.empty;
    if (text.length < 3) return TitleInputError.tooShort;
    if (text.length > 50) return TitleInputError.tooLong;

    return null;
  }

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case TitleInputError.empty:
        return 'El título es requerido';
      case TitleInputError.tooShort:
        return 'Debe tener al menos 3 caracteres';
      case TitleInputError.tooLong:
        return 'No puede exceder los 50 caracteres';
      default:
        return null;
    }
  }
}
