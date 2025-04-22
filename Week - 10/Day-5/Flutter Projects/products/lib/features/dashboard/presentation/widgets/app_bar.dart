import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom app bar for the dashboard
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue, // Blue app bar
      foregroundColor: Colors.white, // White text/icons
      elevation: 4, // Shadow for depth
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}