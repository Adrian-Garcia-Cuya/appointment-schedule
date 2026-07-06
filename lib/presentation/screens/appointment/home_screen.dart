



import 'package:book_appointment/presentation/views/appointment/home_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-appointment';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Appointment')),
      body: const HomeView()
    );
  }
}