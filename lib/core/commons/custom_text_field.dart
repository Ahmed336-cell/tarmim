import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.maxLines, required this.label});
  final int maxLines;
  final String label;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
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
