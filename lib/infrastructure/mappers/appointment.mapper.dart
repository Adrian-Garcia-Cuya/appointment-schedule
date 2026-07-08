import 'package:book_appointment/presentation/providers/appointment/register/register_appointment.model.dart';

class AppointmentMapper {
  static Map<String, dynamic> toJson(AppointmentModel appointment) {
    final selectedDate = appointment.date.value;
    final selectedTime = appointment.time.value;

    final DateTime combinedDateTime = DateTime(
      selectedDate!.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime!.hour,
      selectedTime.minute,
    );

    return {
      'title': appointment.title.value,
      'description': appointment.description.value,
      'email': appointment.email.value,
      'date': combinedDateTime.toUtc().toIso8601String(),
      'status': 'pending',
    };
  }
}
