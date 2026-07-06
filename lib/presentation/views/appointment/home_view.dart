import 'package:book_appointment/presentation/providers/appointment/register/register_appointment.model.dart';
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentModel = ref.watch(registerAppointmentNotifierProvider);
    final title = appointmentModel.title;
    final description = appointmentModel.description;
    final email = appointmentModel.email;
    final date = appointmentModel.date;
    final time = appointmentModel.time;

    final isPosting = appointmentModel.formStatus == FormStatus.posting;

    void datePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      ).then((selectedDate) {
        if (selectedDate != null) {
          _dateController.text =
              "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
          ref
              .read(registerAppointmentNotifierProvider.notifier)
              .updateDate(selectedDate);
        }
      });
    }

    void timePicker() {
      showTimePicker(context: context, initialTime: TimeOfDay.now()).then((
        selectedTime,
      ) {
        if (!context.mounted) return;

        if (selectedTime != null) {
          _timeController.text = selectedTime.format(context);
          ref
              .read(registerAppointmentNotifierProvider.notifier)
              .updateTime(selectedTime);
        }
      });
    }

    ref.listen(registerAppointmentNotifierProvider, (previous, next) {
      if (next.formStatus == FormStatus.success) {
        _titleController.clear();
        _descriptionController.clear();
        _emailController.clear();
        _dateController.clear();
        _timeController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Cita registrada con éxito!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      if (next.formStatus == FormStatus.failed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al registrar la cita'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                controller: _titleController,
                label: 'Título',
                hintText: 'Ingresa el título de tu cita',
                errorText: title.errorMessage,
                onChanged: (value) {
                  ref
                      .read(registerAppointmentNotifierProvider.notifier)
                      .updateTitle(value);
                },
              ),

              const SizedBox(height: 10),

              CustomTextFormField(
                controller: _descriptionController,
                label: 'Descripción',
                hintText: 'Ingresa tu descripción',
                errorText: description.errorMessage,
                maxLines: 3,
                onChanged: (value) {
                  ref
                      .read(registerAppointmentNotifierProvider.notifier)
                      .updateDescription(value);
                },
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  // --- DATE FIELD ---
                  Expanded(
                    child: CustomTextFormField(
                      controller: _dateController,
                      label: 'Fecha',
                      hintText: 'Elige una fecha',
                      readOnly: true,
                      errorText: date.errorMessage,
                      prefixIcon: const Icon(Icons.calendar_today),
                      onTap: () => datePicker(),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // --- TIME FIELD ---
                  Expanded(
                    child: CustomTextFormField(
                      controller: _timeController,
                      label: 'Hora',
                      hintText: 'Elige una hora',
                      readOnly: true,
                      errorText: time.errorMessage,
                      prefixIcon: const Icon(Icons.access_time),
                      onTap: () => timePicker(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              CustomTextFormField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Ingresa tu correo electrónico',
                errorText: email.errorMessage,
                onChanged: (value) {
                  ref
                      .read(registerAppointmentNotifierProvider.notifier)
                      .updateEmail(value);
                },
              ),

              SizedBox(height: 20),

              FilledButton.tonalIcon(
                onPressed: isPosting
                    ? null
                    : () {
                        ref
                            .read(registerAppointmentNotifierProvider.notifier)
                            .onSubmit();
                      },
                label: isPosting
                    ? const Text('Guardando...')
                    : const Text('Guardar cita'),
                icon: isPosting
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
