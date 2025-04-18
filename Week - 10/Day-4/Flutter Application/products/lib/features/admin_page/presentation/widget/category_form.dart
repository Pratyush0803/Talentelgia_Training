import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text_field.dart';

// CategoryForm: Form for adding or updating categories with a modern, animated UI
class CategoryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final String? editingCategoryId;
  final TextEditingController nameController;
  final TextEditingController imageController;
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;

  const CategoryForm({
    super.key,
    required this.formKey,
    required this.isLoading,
    this.editingCategoryId,
    required this.nameController,
    required this.imageController,
    required this.onSubmit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.98 < 500 ? screenWidth * 0.98 : 500.0; // Increased width to 98%

    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: cardWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.green[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: 'Category Name',
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: imageController,
                    label: 'Category Image URL',
                    icon: Icons.image,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AnimatedButton(
                        isLoading: isLoading,
                        onPressed: onSubmit,
                        icon: Icons.save,
                        label: editingCategoryId == null ? 'Add Category' : 'Update Category',
                        color: Colors.green[600]!,
                      ),
                      if (editingCategoryId != null && onCancel != null) ...[
                        const SizedBox(width: 16),
                        _AnimatedButton(
                          isLoading: isLoading,
                          onPressed: onCancel!,
                          label: 'Cancel',
                          color: Colors.grey[600]!,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// _AnimatedButton: Custom button with hover animation and loading state
class _AnimatedButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;
  final Color color;
  final IconData? icon;

  const _AnimatedButton({
    required this.isLoading,
    required this.onPressed,
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ElevatedButton.icon(
          onPressed: widget.isLoading ? null : widget.onPressed,
          icon: widget.icon != null
              ? Icon(widget.icon, color: Colors.white, size: 24)
              : const SizedBox.shrink(),
          label: widget.isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _isHovered ? 8 : 4,
            shadowColor: widget.color.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
