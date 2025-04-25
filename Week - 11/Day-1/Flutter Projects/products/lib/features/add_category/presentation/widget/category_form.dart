import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/add_category_entity.dart';
import '../bloc/add_category_bloc.dart';
import '../bloc/add_category_event.dart';

class CategoryForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic>? categoryData;
  final void Function(CategoryFormState) onStateCreated;

  const CategoryForm({
    super.key,
    required this.formKey,
    this.categoryData,
    required this.onStateCreated,
  });

  @override
  CategoryFormState createState() => CategoryFormState();
}

class CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String? _categoryId;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    // Notify parent widget of state creation
    widget.onStateCreated(this);
    debugPrint('CategoryForm initialized with context: $context');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.categoryData != null && mounted) {
      // Safely initialize form with category data
      _categoryId = widget.categoryData?['categoryId']?.toString();
      _nameController.text = widget.categoryData?['name']?.toString() ?? '';
      _imageUrlController.text = widget.categoryData?['image_url']?.toString() ?? '';
      _isEditMode = true;
      debugPrint('Form initialized with categoryData: categoryId: $_categoryId, name: ${_nameController.text}, image_url: ${_imageUrlController.text}');
    } else {
      debugPrint('No categoryData provided or widget not mounted');
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    debugPrint('Submitting form: isEditMode: $_isEditMode, categoryId: $_categoryId');
    if (widget.formKey.currentState!.validate()) {
      final category = AddCategoryEntity(
        name: _nameController.text,
        image_url: _imageUrlController.text.isEmpty ? null : _imageUrlController.text,
        timestamp: DateTime.now(),
      );
      if (_isEditMode && _categoryId != null) {
        debugPrint('Dispatching UpdateCategoryEvent with categoryId: $_categoryId, name: ${category.name}, image_url: ${category.image_url}');
        context.read<AddCategoryBloc>().add(UpdateCategoryEvent(
          categoryId: _categoryId!,
          category: category,
        ));
      } else {
        debugPrint('Dispatching AddNewCategoryEvent with name: ${category.name}, image_url: ${category.image_url}');
        context.read<AddCategoryBloc>().add(AddNewCategoryEvent(category));
      }
    } else if (mounted) {
      debugPrint('Form validation failed');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill the category name')),
      );
    }
  }

  void resetForm() {
    debugPrint('Resetting form');
    _nameController.clear();
    _imageUrlController.clear();
    setState(() {
      _categoryId = null;
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isEditMode ? 'Edit Category Details' : 'Enter Category Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter category name',
              prefixIcon: const Icon(Icons.category),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.green[50],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _imageUrlController,
            decoration: InputDecoration(
              hintText: 'Enter image URL (Optional)',
              prefixIcon: const Icon(Icons.image),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[200]!),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.green[50],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(_isEditMode ? 'Update Category' : 'Add Category'),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: resetForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}