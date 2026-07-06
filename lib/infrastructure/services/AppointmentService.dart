import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  final FirebaseFirestore _firestore;

  AppointmentService(this._firestore);

  Future<void> createAppointment(Map<String, dynamic> appointment) async {
    await _firestore.collection("appointment").add(appointment);
  }
}
