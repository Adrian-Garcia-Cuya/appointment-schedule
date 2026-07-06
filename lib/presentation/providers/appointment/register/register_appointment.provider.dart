import 'package:book_appointment/presentation/providers/appointment/register/register_appointment.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterAppointmentNotifier extends Notifier<AppointmentModel> {
  
  @override
  AppointmentModel build() => const AppointmentModel();

  void updateTitle(String value) {
    state = state.copyWith(title: value);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }

  void updateDate(DateTime value) {
    state = state.copyWith(date: value);
  }

  void updateTime(TimeOfDay value) {
    state = state.copyWith(time: value);
  }

  void onSubmit() {
    print(state);
  }
}

final registerAppointmentNotifierProvider = NotifierProvider<RegisterAppointmentNotifier, AppointmentModel>(RegisterAppointmentNotifier.new);