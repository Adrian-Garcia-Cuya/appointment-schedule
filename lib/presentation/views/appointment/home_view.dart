import 'package:book_appointment/presentation/providers/appointment/register/register_appointment.provider.dart';
import 'package:book_appointment/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentModel = ref.watch(registerAppointmentNotifierProvider);

    void datePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      ).then((selectedDate) {
        if (selectedDate != null) {
          _dateController.text = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
          ref.read(registerAppointmentNotifierProvider.notifier).updateDate(selectedDate);
        }
      });
    }

    void timePicker() {
      showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
      ).then((selectedTime) {
        if (!context.mounted) return;

        if (selectedTime != null) {
          _timeController.text = selectedTime.format(context);
          ref.read(registerAppointmentNotifierProvider.notifier).updateTime(selectedTime);
        }
      });
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Title',
                hintText: 'Enter your title',
                errorText: 'Title is required',
                onChanged: (value) {
                  ref.read(registerAppointmentNotifierProvider.notifier).updateTitle(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Field is required';
                  return null;
                },
              ),

              const SizedBox(height: 10),
              
              CustomTextFormField(
                label: 'Description',
                hintText: 'Enter your description',
                errorText: 'Description is required',
                maxLines: 3,
                onChanged: (value) {
                  ref.read(registerAppointmentNotifierProvider.notifier).updateDescription(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Field is required';
                  return null;
                },
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  // --- DATE FIELD ---
                  Expanded(
                    child: CustomTextFormField(
                      controller: _dateController,
                      label: 'Date',
                      hintText: 'Enter your date',
                      readOnly: true,
                      prefixIcon: const Icon(Icons.calendar_today),
                      onTap: () => datePicker(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // --- TIME FIELD ---
                  Expanded(
                    child: CustomTextFormField(
                      controller: _timeController,
                      label: 'Time',
                      hintText: 'Enter your time',
                      readOnly: true,
                      prefixIcon: const Icon(Icons.access_time),
                      onTap: () => timePicker(),
                    ),
                    //TODO: Falta implementar las validaciones de los campos y el boton de guardar
                  ),  
                ],
              )
            ], 
          ),
        ), 
      ),
    );
  }
}