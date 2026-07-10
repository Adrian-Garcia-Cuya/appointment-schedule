import 'package:book_appointment/infrastructure/inputs/date.dart';
import 'package:book_appointment/infrastructure/inputs/description.dart';
import 'package:book_appointment/infrastructure/inputs/email.dart';
import 'package:book_appointment/infrastructure/inputs/time.dart';
import 'package:book_appointment/infrastructure/inputs/title.dart';
import 'package:formz/formz.dart';

enum FormStatus { invalid, valid, validating, posting, success, failed }

class AppointmentModel with FormzMixin {
  final FormStatus formStatus;
  final TitleInput title;
  final DescriptionInput description;
  final List<EmailInput> emails;
  final DateInput date;
  final TimeInput time;

  const AppointmentModel({
    this.formStatus = FormStatus.invalid,
    this.title = const TitleInput.pure(),
    this.description = const DescriptionInput.pure(),
    this.emails = const [],
    this.date = const DateInput.pure(),
    this.time = const TimeInput.pure(),
  });

  @override
  List<FormzInput<dynamic, dynamic>> get inputs {
    return [
      title,
      description,
      date,
      time,
      if (emails.isEmpty) const EmailInput.pure() else ...emails,
    ];
  }

  AppointmentModel copyWith({
    FormStatus? formStatus,
    TitleInput? title,
    DescriptionInput? description,
    EmailInput? email,
    List<EmailInput>? emails,
    DateInput? date,
    TimeInput? time,
  }) {
    return AppointmentModel(
      formStatus: formStatus ?? this.formStatus,
      title: title ?? this.title,
      description: description ?? this.description,
      emails: emails ?? this.emails,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
