import 'package:book_appointment/config/constants/environment.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_appointment/infrastructure/services/appointment.service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );
});

final appointmentServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AppointmentService(dio);
});
