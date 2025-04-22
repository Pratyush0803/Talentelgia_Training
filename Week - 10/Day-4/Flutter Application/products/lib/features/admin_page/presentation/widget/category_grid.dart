import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/category_entity.dart';

// CategoryGrid: Displays categories in a responsive grid with animated, modern cards
class CategoryGrid extends StatelessWidget {
  final bool isLoading;
  final List<Category> categories;
  final Function(String) onView;
  final Function(String) onEdit;
  final Function(String) onDelete;

  const CategoryGrid({
    super.key,
    required this.isLoading,
    required this.categories,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    print('CategoryGrid: Rendering ${categories.length} categories');
    if (isLoading) {
      return const Center(
        child: _CustomLoadingIndicator(),
      );
    }
    if (categories.isEmpty) {
      return Center(
        child: Text(
          'No categories available',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      );
    }
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16.0 : 20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _calculateCrossAxisCount(context),
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 2.0, // Reduced for taller cards
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryCard(
              category: category,
              onView: onView,
              onEdit: onEdit,
              onDelete: onDelete,
            );
          },
        ),
      ),
    );
  }

  // Calculate Grid Columns: Responsive column count for category grid
  int _calculateCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 900) return 3;
    return 2;
  }
}

// _CategoryCard: Individual category card with hover animation
class _CategoryCard extends StatefulWidget {
  final Category category;
  final Function(String) onView;
  final Function(String) onEdit;
  final Function(String) onDelete;

  const _CategoryCard({
    required this.category,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: _isHovered ? 8 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.green[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left image with gradient overlay
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.category.imageUrl ?? '',
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 160,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80, // Increased for taller cards
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Increased padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Centered title
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.category.name,
                                style: GoogleFonts.poppins(
                                  fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3, // Increased for longer names
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          // Action buttons with labels
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _LabeledActionButton(
                                  icon: Icons.visibility,
                                  label: 'View',
                                  color: Colors.green[600]!,
                                  onPressed: () => widget.onView(widget.category.id),
                                ),
                                const SizedBox(width: 8),
                                _LabeledActionButton(
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  color: Colors.blue[600]!,
                                  onPressed: () => widget.onEdit(widget.category.id),
                                ),
                                const SizedBox(width: 8),
                                _LabeledActionButton(
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  color: Colors.red[600]!,
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          'Delete Category',
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                        ),
                                        content: Text(
                                          'Are you sure you want to delete "${widget.category.name}"?',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: Text('Cancel', style: GoogleFonts.poppins()),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: Text(
                                              'Delete',
                                              style: GoogleFonts.poppins(color: Colors.red[600]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) widget.onDelete(widget.category.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

// _LabeledActionButton: Button with icon and text label below
class _LabeledActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _LabeledActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  _LabeledActionButtonState createState() => _LabeledActionButtonState();
}

class _LabeledActionButtonState extends State<_LabeledActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: widget.color,
              shape: const CircleBorder(),
              elevation: _isHovered ? 6 : 2,
              child: IconButton(
                icon: Icon(widget.icon, color: Colors.white, size: 14),
                onPressed: widget.onPressed,
                splashRadius: 18,
                constraints: const BoxConstraints.tightFor(width: 32, height: 32),
                padding: const EdgeInsets.all(6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width < 600 ? 9 : 10,
                fontWeight: FontWeight.w500,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _CustomLoadingIndicator: Enhanced loading animation
class _CustomLoadingIndicator extends StatelessWidget {
  const _CustomLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          color: Colors.green[600],
          strokeWidth: 3,
        ),
        const SizedBox(height: 16),
        Text(
          'Loading categories...',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}