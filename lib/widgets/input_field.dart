import 'package:flutter/material.dart';

// InputField Widget
class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  // Constructor for InputField
  InputField({
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // For password field
        keyboardType: inputType, // Set the input type (text, email, etc.)
        decoration: InputDecoration(
          hintText: hintText, // Placeholder text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true, // Fill background color
          fillColor: Colors.grey[200], // Light gray color
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        ),
        validator: validator, // Optional validation for input
      ),
    );
  }
}
