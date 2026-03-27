import 'package:flutter/material.dart';

class CajaTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;

  const CajaTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: textStyle,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: labelStyle,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
