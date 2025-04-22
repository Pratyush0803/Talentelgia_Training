import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// CustomAppBar: Displays the title based on the selected option
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedOption;

  const CustomAppBar({super.key, required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    String title;
    switch (selectedOption) {
      case 'Add Products by Category':
        title = 'Product Information';
        break;
      case 'Category Management':
        title = 'Manage Categories';
        break;
      default:
        title = 'Category Information';
    }
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green[600],
      elevation: 4,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[300]!, Colors.green[500]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}