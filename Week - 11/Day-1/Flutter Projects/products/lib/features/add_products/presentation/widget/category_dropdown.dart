import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDropdown extends StatefulWidget {
  final Function(String?) onCategorySelected;
  final String? selectedCategoryId;
  final String? Function(String?)? validator;

  const CategoryDropdown({
    super.key,
    required this.onCategorySelected,
    this.selectedCategoryId,
    this.validator,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<Map<String, String>> _categories = [];
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.selectedCategoryId;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories = snapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'name': data['name']?.toString() ?? doc.id,
          };
        }).toList();
        if (_categories.isNotEmpty && _selectedCategoryId == null) {
          _selectedCategoryId = _categories.first['id'];
          widget.onCategorySelected(_selectedCategoryId);
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load categories: $e')),
        );
      }
    }
  }

  @override
  void didUpdateWidget(covariant CategoryDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategoryId != oldWidget.selectedCategoryId) {
      setState(() {
        _selectedCategoryId = widget.selectedCategoryId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedCategoryId != null && _categories.any((cat) => cat['id'] == _selectedCategoryId)
          ? _selectedCategoryId
          : _categories.isNotEmpty ? _categories.first['id'] : null,
      hint: const Text('Select Category'),
      items: _categories.map((category) {
        return DropdownMenuItem<String>(
          value: category['id'],
          child: Text(category['name'] ?? 'Unnamed Category'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategoryId = value;
          widget.onCategorySelected(value);
        });
      },
      decoration: InputDecoration(
        hintText: 'Select Category',
        prefixIcon: const Icon(Icons.category),
        filled: true,
        fillColor: Colors.green[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[200]!),
        ),
      ),
      validator: widget.validator,
    );
  }
}