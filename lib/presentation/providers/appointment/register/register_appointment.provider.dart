import 'package:book_appointment/infrastructure/inputs/date.dart';
import 'package:book_appointment/infrastructure/inputs/description.dart';
import 'package:book_appointment/infrastructure/inputs/email.dart';
import 'package:book_appointment/infrastructure/inputs/time.dart';
import 'package:book_appointment/infrastructure/inputs/title.dart';
import 'package:book_appointment/infrastructure/mappers/appointment.mapper.dart';
import 'package:book_appointment/presentation/providers/appointment/register/register_appointment.model.dart';
import 'package:book_appointment/presentation/providers/services/appointment.service.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RegisterAppointmentNotifier extends Notifier<AppointmentModel> {
  @override
  AppointmentModel build() => const AppointmentModel();

  void updateTitle(String value) {
    state = state.copyWith(
      title: TitleInput.dirty(value),
      formStatus: FormStatus.invalid,
    );
  }

  void updateDescription(String value) {
    state = state.copyWith(
      description: DescriptionInput.dirty(value),
      formStatus: FormStatus.invalid,
    );
  }

  void updateDate(DateTime value) {
    state = state.copyWith(
      date: DateInput.dirty(value),
      formStatus: FormStatus.invalid,
    );
  }

  void updateTime(TimeOfDay value) {
    state = state.copyWith(
      time: TimeInput.dirty(value),
      formStatus: FormStatus.invalid,
    );
  }

  void updateEmail(String value) {
    state = state.copyWith(
      email: EmailInput.dirty(value),
      formStatus: FormStatus.invalid,
    );
  }

  void resetForm() {
    state = const AppointmentModel();
  }

  Future<void> onSubmit() async {
    if (!state.isValid) {
      state = state.copyWith(
        formStatus: FormStatus.invalid,
        title: TitleInput.dirty(state.title.value),
        description: DescriptionInput.dirty(state.description.value),
        email: EmailInput.dirty(state.email.value),
        date: DateInput.dirty(state.date.value),
        time: TimeInput.dirty(state.time.value),
      );
      return;
    }

    state = state.copyWith(formStatus: FormStatus.posting);

    try {
      final appointmentService = ref.read(appointmentServiceProvider);
      final mapper = AppointmentMapper.toJson(state);
      await appointmentService.createAppointment(mapper);

      state = state.copyWith(formStatus: FormStatus.success);
      resetForm();
    } catch (e) {
      state = state.copyWith(formStatus: FormStatus.failed);
      debugPrint('[Error]: Error al registrar la cita: ${e.toString()}');
    }
  }
}

final registerAppointmentNotifierProvider =
    NotifierProvider<RegisterAppointmentNotifier, AppointmentModel>(
      RegisterAppointmentNotifier.new,
    );
