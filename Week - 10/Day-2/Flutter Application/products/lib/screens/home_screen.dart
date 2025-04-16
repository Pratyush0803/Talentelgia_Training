import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isAddingProduct = true;

  final descriptionController = TextEditingController();
  final subDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();

  final categoryNameController = TextEditingController();
  final categoryImageController = TextEditingController();

  List<String> categories = [];
  String selectedCategory = '';
  String selectedExistingCategory = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['name'] as String).toList();
      if (categories.isNotEmpty) selectedCategory = categories.first;
    });
  }

  Future<void> addCategoryToFirestore() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to add a category')),
      );
      return;
    }

    if (categoryNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a Category Name')),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final name = categoryNameController.text.trim();
      final imageUrl = categoryImageController.text.trim();
      final categoryId = name.toLowerCase().replaceAll(' ', '_');

      final categoryData = {
        'name': name,
        'timestamp': FieldValue.serverTimestamp(),
        if (imageUrl.isNotEmpty) 'image_url': imageUrl,
        'created_by': user.uid, // Store the UID of the user who added the category
      };

      await FirebaseFirestore.instance.collection('categories').doc(categoryId).set(categoryData);

      categoryNameController.clear();
      categoryImageController.clear();
      _loadCategories();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Category added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addProductToFirestore() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to add a product')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final category = selectedCategory.toLowerCase().replaceAll(' ', '_');

        // Build the product data map
        Map<String, dynamic> productData = {
          'description': descriptionController.text.trim(),
          'image_url': imageUrlController.text.trim(),
          'price': double.tryParse(priceController.text.trim()) ?? 0.0,
          'timestamp': FieldValue.serverTimestamp(),
          'created_by': user.uid,
        };

        // Only include sub_description if it's not empty
        if (subDescriptionController.text.trim().isNotEmpty) {
          productData['sub_description'] = subDescriptionController.text.trim();
        }

        // Add the product to the Firestore collection
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(category)
            .collection('products')
            .add(productData);

        // Clear the text controllers
        descriptionController.clear();
        subDescriptionController.clear();
        imageUrlController.clear();
        priceController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Product added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error: $e')),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> deleteCategory(String name) async {
    final categoryId = name.toLowerCase().replaceAll(' ', '_');
    await FirebaseFirestore.instance.collection('categories').doc(categoryId).delete();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text('Menu', style: TextStyle(fontSize: 24))),
            ListTile(
              title: const Text('Add Products by Category'),
              onTap: () {
                setState(() => isAddingProduct = true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add Category'),
              onTap: () {
                setState(() => isAddingProduct = false);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(title: const Text("Category & Product Manager")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      isAddingProduct ? "Product Information" : "Category Information",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    if (isAddingProduct) ...[
                      _buildDropdown(),
                      const SizedBox(height: 16),
                      _buildTextField(descriptionController, 'Product Description', Icons.description),
                      const SizedBox(height: 16),
                      _buildTextField(subDescriptionController, 'Sub-description (Optional)', Icons.text_fields, required: false),
                      const SizedBox(height: 16),
                      _buildTextField(imageUrlController, 'Image URL', Icons.image),
                      const SizedBox(height: 16),
                      _buildTextField(priceController, 'Product Price', Icons.attach_money, keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: isLoading ? null : addProductToFirestore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Add Product', style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                      ),
                    ] else ...[
                      _buildTextField(categoryNameController, 'Category Name', Icons.category),
                      const SizedBox(height: 16),
                      _buildTextField(categoryImageController, 'Category Image URL (Optional)', Icons.image, required: false),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: isLoading ? null : addCategoryToFirestore,
                        icon: const Icon(Icons.add_box_rounded),
                        label: const Text("Add Category"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text("Existing Categories"),
                      _buildExistingCategoryDropdown(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text, bool required = true}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _fieldDecoration(label).copyWith(prefixIcon: Icon(icon)),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory.isNotEmpty ? selectedCategory : null,
      decoration: _fieldDecoration('Select Category'),
      items: categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
      onChanged: (value) => setState(() => selectedCategory = value!),
    );
  }

  Widget _buildExistingCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedExistingCategory.isNotEmpty ? selectedExistingCategory : null,
      decoration: _fieldDecoration('Select Existing Category'),
      items: categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteCategory(category),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => selectedExistingCategory = value!),
    );
  }
}
