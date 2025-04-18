import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// CustomTextField: Reusable form field with validation
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool required;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.required = true,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[600]!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[400]!),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[400]!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon ?? (icon != null ? Icon(icon, color: Colors.green[600], size: 24) : null),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        if (label == 'Image URL' || label == 'Category Image URL') {
          if (value!.isEmpty) {
            return 'Image URL cannot be empty';
          }
          final uri = Uri.tryParse(value);
          if (uri == null || !uri.isAbsolute || !['http', 'https'].contains(uri.scheme)) {
            return 'Please enter a valid URL (http or https)';
          }
        }
        return null;
      },
    );
  }
}