import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/category_entity.dart';

// CustomDropdown: Category selection dropdown for product form
class CustomDropdown extends StatelessWidget {
  final List<Category> categories;
  final bool isLoading;
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.categories,
    required this.isLoading,
    this.selectedCategoryId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Text(
        'No categories available',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }
    return DropdownButtonFormField<String>(
      value: selectedCategoryId,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        labelText: 'Select Category',
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
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      items: categories
          .map(
            (category) => DropdownMenuItem<String>(
          value: category.id,
          child: Text(
            category.name,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
      )
          .toList(),
      onChanged: isLoading ? null : onChanged,
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }
}