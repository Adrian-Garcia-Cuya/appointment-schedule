

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String? label;
  final String? hintText;
  final String? errorText;
  final int? maxLines;
  final bool readOnly;
  final Icon? prefixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;
  

  const CustomTextFormField({
    super.key, 
    this.label, 
    this.hintText, 
    this.maxLines,
    this.readOnly = false,
    this.errorText, 
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return TextFormField(
      readOnly: readOnly,
      maxLines: maxLines,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: Colors.blue)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        focusColor: Colors.blue,
        isDense: true,
        label: label != null ? Text(label!): null,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon
      ),
    );
  }
}