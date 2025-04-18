import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/category_entity.dart';
import 'dropdown.dart';
import 'text_field.dart';

// ProductForm: Form for adding or updating products with a modern, animated UI
class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final List<Category> categories;
  final String? editingProductId;
  final TextEditingController descriptionController;
  final TextEditingController subDescriptionController;
  final TextEditingController imageUrlController;
  final String? selectedCategoryId;
  final Function(String) onCategorySelected;
  final Function(String?) onSubmit;
  final VoidCallback? onCancel;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.isLoading,
    required this.categories,
    this.editingProductId,
    required this.descriptionController,
    required this.subDescriptionController,
    required this.imageUrlController,
    this.selectedCategoryId,
    required this.onCategorySelected,
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
                  SizedBox(
                    width: double.infinity,
                    child: CustomDropdown(
                      categories: categories,
                      isLoading: isLoading,
                      selectedCategoryId: selectedCategoryId,
                      onChanged: (value) => onCategorySelected(value!),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: descriptionController,
                    label: 'Product Description',
                    icon: Icons.description,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: subDescriptionController,
                    label: 'Sub-description (Optional)',
                    icon: Icons.text_fields,
                    required: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: imageUrlController,
                    label: 'Image URL',
                    icon: Icons.image,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _AnimatedButton(
                        isLoading: isLoading || categories.isEmpty,
                        onPressed: () => onSubmit(selectedCategoryId),
                        icon: Icons.save,
                        label: editingProductId == null ? 'Add Product' : 'Update Product',
                        color: Colors.green[600]!,
                      ),
                      if (editingProductId != null && onCancel != null) ...[
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
