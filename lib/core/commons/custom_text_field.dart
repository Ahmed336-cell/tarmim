import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.maxLines, required this.label, required  this.controller});
  final int maxLines;
  final String label;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(label),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}