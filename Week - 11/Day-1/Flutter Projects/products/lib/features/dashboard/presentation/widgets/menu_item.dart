import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Reusable menu item widget for sidebar navigation
class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white), // Icon for menu item
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap, // Navigate on tap
      hoverColor: Colors.blue[700], // Hover effect
    );
  }
}