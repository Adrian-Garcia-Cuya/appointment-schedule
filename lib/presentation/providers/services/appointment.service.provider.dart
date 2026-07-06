import 'package:book_appointment/infrastructure/services/AppointmentService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentServiceProvider = Provider((ref) {
  return AppointmentService(FirebaseFirestore.instance);
});
