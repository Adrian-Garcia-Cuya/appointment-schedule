import 'package:book_appointment/infrastructure/inputs/email.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CustomInputChipField extends StatefulWidget {
  final List<EmailInput> emails;
  final TextEditingController controller;
  final void Function(String value) onAddEmail;
  final void Function(int index) onRemoveEmail;
  final String? errorText;

  const CustomInputChipField({
    super.key,
    required this.emails,
    required this.controller,
    required this.onAddEmail,
    required this.onRemoveEmail,
    this.errorText,
  });

  @override
  State<CustomInputChipField> createState() => _CustomInputChipFieldState();
}

class _CustomInputChipFieldState extends State<CustomInputChipField> {
  EmailInput email = const EmailInput.dirty('');

  @override
  Widget build(BuildContext context) {
    final hasError =
        widget.errorText != null || (email.value != '' && !email.isValid);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: hasError ? Colors.red.shade900 : Colors.black,
            ),
          ),
          child: Wrap(
            spacing: 5,
            children: [
              ...widget.emails
                  .mapIndexed((index, email) {
                    final isChipInvalid = !email.isValid;
                    return [
                      InputChip(
                        label: Text(email.value),
                        labelStyle: isChipInvalid
                            ? TextStyle(color: Colors.red.shade900)
                            : TextStyle(color: Colors.green.shade800),
                        side: isChipInvalid
                            ? BorderSide(color: Colors.red.shade900)
                            : BorderSide(color: Colors.green.shade800),
                        backgroundColor: isChipInvalid
                            ? Colors.red.shade50
                            : null,
                        onDeleted: () {
                          widget.onRemoveEmail(index);
                        },
                      ),
                    ];
                  })
                  .expand((element) => element),

              IntrinsicWidth(
                child: TextField(
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Agrega un email',
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusColor: Colors.transparent,
                  ),
                  onSubmitted: widget.onAddEmail,
                  onChanged: (value) {
                    email = EmailInput.dirty(value);

                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),

        if (hasError) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              (email.value != '' && !email.isValid)
                  ? (email.errorMessage ?? '')
                  : (widget.errorText ?? ''),
              style: TextStyle(
                color: Colors.red.shade900,
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
