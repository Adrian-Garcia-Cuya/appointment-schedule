import 'package:dio/dio.dart';

class AppointmentService {
  final Dio _dio;

  AppointmentService(this._dio);

  Future<void> createAppointment(Map<String, dynamic> appointment) async {
    await _dio.post('/appointment', data: appointment);
  }
}
