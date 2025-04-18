import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'menu_item.dart';

// Sidebar: Navigation menu with options for adding/managing categories and products
class Sidebar extends StatelessWidget {
  final bool isLoading;
  final String selectedOption;
  final Function(String) onOptionSelected;
  final VoidCallback onSignOut;

  const Sidebar({
    super.key,
    required this.isLoading,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Blibkit',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Admin Panel',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 4, color: Colors.green),
            MenuItem(
              title: 'Add Products',
              option: 'Add Products by Category',
              onTap: () => onOptionSelected('Add Products by Category'),
              isSelected: selectedOption == 'Add Products by Category',
            ),
            const Divider(color: Colors.green),
            MenuItem(
              title: 'Add Category',
              option: 'Add Category',
              onTap: () => onOptionSelected('Add Category'),
              isSelected: selectedOption == 'Add Category',
            ),
            const Divider(color: Colors.green),
            MenuItem(
              title: 'Category Management',
              option: 'Category Management',
              onTap: () => onOptionSelected('Category Management'),
              isSelected: selectedOption == 'Category Management',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isLoading ? null : onSignOut,
                child: Text('Logout', style: GoogleFonts.poppins(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}