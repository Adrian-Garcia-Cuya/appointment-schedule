import 'package:flutter/material.dart';

class AppointmentModel {
  final String title;
  final String description;
  final DateTime? date;
  final TimeOfDay? time;

  const AppointmentModel({
    this.title = '',
    this.description = '',
    this.date,
    this.time,
  });

  AppointmentModel copyWith({
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
  }) {
    return AppointmentModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}