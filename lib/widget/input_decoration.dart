import 'package:flutter/material.dart';

InputDecoration myInputDecoration({
  required IconData icon,
  required String label,
  required String hintText,
}) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: Colors.blueAccent,
    ),
    helperText: '',
    labelText: label,
    hintText: hintText,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    ),
  );
}
