import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// MenuItem: Sidebar navigation item
class MenuItem extends StatelessWidget {
  final String title;
  final String option;
  final VoidCallback onTap;
  final bool isSelected;

  const MenuItem({
    super.key,
    required this.title,
    required this.option,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.green[600] : Colors.black,
          ),
        ),
      ),
    );
  }
}