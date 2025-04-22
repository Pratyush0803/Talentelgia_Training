import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entity/add_product_entity.dart';
import '../bloc/add_product_bloc.dart';
import '../bloc/add_product_event.dart';
import '../bloc/add_product_state.dart';
import '../widget/category_dropdown.dart';

class AddProductPage extends StatefulWidget {
  final Map<String, dynamic>? extraData;

  const AddProductPage({super.key, this.extraData});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _subDescriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String? _selectedCategoryId;
  final String _createdBy = 'mPXY9QYUwLe4cj9457iOOlJGSDy2'; // Hardcoded or from auth context
  bool _isEditMode = false;
  String? _productId;

  @override
  void initState() {
    super.initState();
    print('AddProductPage initState - extraData: ${widget.extraData}'); // Debug log
    _loadCategories();
    _initializeFormWithData();
  }

  void _initializeFormWithData() {
    print('Initializing form with extraData: ${widget.extraData}'); // Debug log
    if (widget.extraData != null && widget.extraData!['isEdit'] == true) {
      print('Entering edit mode with data: ${widget.extraData}'); // Debug log
      _isEditMode = true;
      _productId = widget.extraData!['id'] as String?;
      // Only set _selectedCategoryId if category_id is valid, otherwise leave it null
      _selectedCategoryId = widget.extraData!['category_id']?.toString().isNotEmpty == true
          ? widget.extraData!['category_id'] as String?
          : null;
      _descriptionController.text = widget.extraData!['description']?.toString() ?? '';
      _subDescriptionController.text = widget.extraData!['sub_description']?.toString() ?? '';
      _imageUrlController.text = widget.extraData!['image_url']?.toString() ?? '';
      setState(() {}); // Ensure UI updates with new state
    } else {
      print('No edit data or not in edit mode'); // Debug log
    }
  }

  Future<void> _loadCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      if (snapshot.docs.isNotEmpty && mounted) {
        setState(() {
          if (_selectedCategoryId == null && !_isEditMode) {
            _selectedCategoryId = snapshot.docs.first.id;
          }
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No categories found in Firestore')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load categories: $e')),
        );
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      final product = AddProductEntity(
        category_id: _selectedCategoryId!,
        description: _descriptionController.text,
        sub_description: _subDescriptionController.text.isEmpty ? null : _subDescriptionController.text,
        image_url: _imageUrlController.text,
        created_by: _createdBy,
        timestamp: DateTime.now(), // Will be overridden by server timestamp
      );
      if (_isEditMode && _productId != null) {
        context.read<AddProductBloc>().add(EditProductEvent(_selectedCategoryId!, _productId!, product));
      } else {
        context.read<AddProductBloc>().add(AddNewProductEvent(product));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields and select a category')),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedCategoryId = null;
      _isEditMode = false;
      _productId = null;
    });
    _descriptionController.clear();
    _subDescriptionController.clear();
    _imageUrlController.clear();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _subDescriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Product ${ _isEditMode ? 'updated' : 'added' } successfully!'),
            ),
          );
          _resetForm();
          if (_isEditMode && mounted) context.pop();
        } else if (state is AddProductFailure && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEditMode ? 'Edit Product' : 'Add Product'),
            backgroundColor: Colors.green[700],
            elevation: 0,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width < 600 ? double.infinity : 500,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Enter Product Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                            const SizedBox(height: 24),
                            CategoryDropdown(
                              onCategorySelected: (categoryId) {
                                setState(() {
                                  _selectedCategoryId = categoryId;
                                });
                              },
                              selectedCategoryId: _selectedCategoryId,
                              validator: (value) => value == null ? 'Please select a category' : null,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: _descriptionController,
                              hintText: 'Enter product description',
                              icon: Icons.description,
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _subDescriptionController,
                              hintText: 'Enter sub-description (Optional)',
                              icon: Icons.notes,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _imageUrlController,
                              hintText: 'Enter image URL',
                              icon: Icons.image,
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _submitForm,
                                    label: Text(_isEditMode ? 'Update Product' : 'Add Product'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[600],
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: _resetForm,
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.green[50],
      ),
      validator: validator,
    );
  }
}