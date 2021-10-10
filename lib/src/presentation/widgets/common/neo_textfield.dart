import 'package:flutter/material.dart';

class NeoTextField extends StatelessWidget {
  const NeoTextField({
    required this.validatorFn,
    required this.hint,
    required this.prefixIcon,
    required this.onSavedFn,
  });

  final String? Function(String? value) validatorFn;
  final String? Function(String? value) onSavedFn;
  final Widget prefixIcon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        errorStyle: TextStyle(color: Colors.white, fontSize: 12),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.white)),
      ),
      validator: validatorFn,
      onSaved: onSavedFn,
    );
  }
}
