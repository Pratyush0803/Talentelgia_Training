import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isAddingProduct = true;
  bool isManagingCategory = false;
  String? editingCategoryId;
  String? selectedCategoryIdForProducts;
  String? editingProductId;

  final descriptionController = TextEditingController();
  final subDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();

  final categoryNameController = TextEditingController();
  final categoryImageController = TextEditingController();

  List<Map<String, dynamic>> categories = [];
  String selectedCategoryId = '';
  String selectedOption = 'Add Products by Category';

  @override
  void initState() {
    super.initState();
    _loadCategories();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  Future<void> _loadCategories() async {
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories =
            snapshot.docs
                .map(
                  (doc) => {
                'id': doc.id,
                'name': doc['name'] as String,
                'image_url': doc['image_url'] as String?,
                'date_added':
                (doc['timestamp'] as Timestamp)
                    .toDate()
                    .toString()
                    .split(' ')[0],
              },
            )
                .toList();
        if (categories.isNotEmpty) selectedCategoryId = categories.first['id']!;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading categories: $e')));
    }
  }

  Future<void> _loadProducts(String categoryId) async {
    setState(() => isLoading = true);
    try {
      final _ =
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .get();
      setState(() {
        selectedCategoryIdForProducts = categoryId;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading products: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> editCategory(String categoryId) async {
    try {
      final doc =
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .get();
      if (doc.exists) {
        setState(() {
          editingCategoryId = categoryId;
          categoryNameController.text = doc['name'] as String;
          categoryImageController.text = doc['image_url'] ?? '';
          isAddingProduct = false;
          isManagingCategory = false;
          selectedOption = 'Add Category';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading category for edit: $e')),
      );
    }
  }

  Future<void> addCategoryToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final name = categoryNameController.text.trim();
    final imageUrl = categoryImageController.text.trim();
    if (name.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category name and image URL cannot be empty'),
        ),
      );
      return;
    }

    // Check for duplicate category name
    final querySnapshot =
    await FirebaseFirestore.instance
        .collection('categories')
        .where('name', isEqualTo: name)
        .get();
    if (querySnapshot.docs.isNotEmpty && editingCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A category with this name already exists'),
        ),
      );
      return;
    }

    final categoryData = {
      'name': name,
      'image_url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'created_by': user.uid,
    };

    setState(() => isLoading = true);
    try {
      final firestore = FirebaseFirestore.instance;
      if (editingCategoryId != null) {
        await firestore
            .collection('categories')
            .doc(editingCategoryId!)
            .update(categoryData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category updated successfully')),
        );
      } else {
        await firestore.collection('categories').add(categoryData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category added successfully')),
        );
      }
      categoryNameController.clear();
      categoryImageController.clear();
      setState(() {
        editingCategoryId = null;
        isAddingProduct = false;
        isManagingCategory = false;
        selectedOption = 'Add Category';
      });
      _loadCategories();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> addProductToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        // Check for duplicate product description in the category
        final querySnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(selectedCategoryId)
            .collection('products')
            .where(
          'description',
          isEqualTo: descriptionController.text.trim(),
        )
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'A product with this description already exists in this category',
              ),
            ),
          );
          setState(() => isLoading = false);
          return;
        }

        Map<String, dynamic> productData = {
          'description': descriptionController.text.trim(),
          'image_url': imageUrlController.text.trim(),
          'price': double.tryParse(priceController.text.trim()) ?? 0.0,
          'timestamp': FieldValue.serverTimestamp(),
          'created_by': user.uid,
          'category_id': selectedCategoryId,
        };
        if (subDescriptionController.text.trim().isNotEmpty) {
          productData['sub_description'] = subDescriptionController.text.trim();
        }
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(selectedCategoryId)
            .collection('products')
            .add(productData);
        descriptionController.clear();
        subDescriptionController.clear();
        imageUrlController.clear();
        priceController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        if (selectedCategoryIdForProducts == selectedCategoryId) {
          _loadProducts(selectedCategoryId);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> editProduct(String categoryId, String productId) async {
    try {
      final doc =
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .get();
      if (doc.exists) {
        setState(() {
          editingProductId = productId;
          descriptionController.text = doc['description'] ?? '';
          subDescriptionController.text = doc['sub_description'] ?? '';
          imageUrlController.text = doc['image_url'] ?? '';
          priceController.text = doc['price']?.toString() ?? '';
          isAddingProduct = true;
          isManagingCategory = false;
          selectedOption = 'Add Products by Category';
          selectedCategoryId = categoryId;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading product for edit: $e')),
      );
    }
  }

  Future<void> updateProductToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        // Check for duplicate product description in the category (excluding self)
        final querySnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(selectedCategoryId)
            .collection('products')
            .where(
          'description',
          isEqualTo: descriptionController.text.trim(),
        )
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          for (final doc in querySnapshot.docs) {
            if (doc.id != editingProductId) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'A product with this description already exists in this category',
                  ),
                ),
              );
              setState(() => isLoading = false);
              return;
            }
          }
        }

        Map<String, dynamic> productData = {
          'description': descriptionController.text.trim(),
          'image_url': imageUrlController.text.trim(),
          'price': double.tryParse(priceController.text.trim()) ?? 0.0,
          'timestamp': FieldValue.serverTimestamp(),
          'created_by': user.uid,
          'category_id': selectedCategoryId,
        };
        if (subDescriptionController.text.trim().isNotEmpty) {
          productData['sub_description'] = subDescriptionController.text.trim();
        }
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(selectedCategoryId)
            .collection('products')
            .doc(editingProductId)
            .update(productData);
        descriptionController.clear();
        subDescriptionController.clear();
        imageUrlController.clear();
        priceController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );
        setState(() {
          editingProductId = null;
          isAddingProduct = true;
          isManagingCategory = false;
          selectedOption = 'Add Products by Category';
        });
        if (selectedCategoryIdForProducts == selectedCategoryId) {
          _loadProducts(selectedCategoryId);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    setState(() => isLoading = true);
    try {
      final productsSnapshot =
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .get();
      for (final doc in productsSnapshot.docs) {
        await doc.reference.delete();
      }
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category deleted successfully')),
      );
      _loadCategories();
      setState(() => selectedCategoryIdForProducts = null);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting category: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteProduct(String categoryId, String productId) async {
    setState(() => isLoading = true);
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );
      if (selectedCategoryIdForProducts == categoryId) {
        _loadProducts(categoryId);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting product: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 2),
                  const SizedBox(height: 24),
                  _buildMenuItem('Add Products by Category', () {
                    setState(() {
                      isAddingProduct = true;
                      isManagingCategory = false;
                      selectedOption = 'Add Products by Category';
                      editingProductId = null;
                    });
                  }),
                  Divider(),
                  _buildMenuItem('Add Category', () {
                    setState(() {
                      isAddingProduct = false;
                      isManagingCategory = false;
                      editingCategoryId = null;
                      selectedOption = 'Add Category';
                    });
                  }),
                  Divider(),
                  _buildMenuItem('Category Management', () {
                    setState(() {
                      isAddingProduct = false;
                      isManagingCategory = true;
                      selectedOption = 'Category Management';
                    });
                  }),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAddingProduct
                            ? "Product Information"
                            : isManagingCategory
                            ? ""
                            : "Category Information",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (isAddingProduct) ...[
                        _buildDropdown(),
                        const SizedBox(height: 12),
                        _buildTextField(
                          descriptionController,
                          'Product Description',
                          Icons.description,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          subDescriptionController,
                          'Sub-description (Optional)',
                          Icons.text_fields,
                          required: false,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          imageUrlController,
                          'Image URL',
                          Icons.image,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          priceController,
                          'Product Price',
                          null,
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 3.0,top: 2),
                            child: Text(
                              '₹',
                              style: TextStyle(fontSize: 24, color: Colors.grey[800]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                          isLoading
                              ? null
                              : (editingProductId == null
                              ? addProductToFirestore
                              : updateProductToFirestore),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 32,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:
                          isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            editingProductId == null
                                ? 'Add Product'
                                : 'Update Product',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ] else if (isManagingCategory) ...[
                        const Text(
                          'Category Management',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SingleChildScrollView(
                            child: DataTable(
                              columnSpacing: 30,
                              dataRowHeight: 60,
                              headingRowHeight: 60,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Filename',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Date Added',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Actions',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                              rows:
                              categories.map((category) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      GestureDetector(
                                        onTap:
                                            () => _loadProducts(
                                          category['id']!,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.network(
                                              category['image_url']
                                                  ?.isNotEmpty ==
                                                  true
                                                  ? category['image_url']
                                                  : 'https://via.placeholder.com/40',
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                  ) {
                                                print(
                                                  'Error loading image for category ${category['name']}: $error',
                                                );
                                                return Container(
                                                  width: 40,
                                                  height: 40,
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    size: 20,
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              category['name']!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        category['date_added'] ?? 'N/A',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.yellow,
                                              size: 30,
                                            ),
                                            onPressed:
                                                () => editCategory(
                                              category['id']!,
                                            ),
                                            padding: const EdgeInsets.all(
                                              8,
                                            ),
                                            constraints:
                                            const BoxConstraints(),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed:
                                                () => deleteCategory(
                                              category['id']!,
                                            ),
                                            padding: const EdgeInsets.all(
                                              8,
                                            ),
                                            constraints:
                                            const BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        if (selectedCategoryIdForProducts != null) ...[
                          const SizedBox(height: 24),
                          const Text(
                            'Products',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(thickness: 3,),
                          StreamBuilder(
                            stream:
                            FirebaseFirestore.instance
                                .collection('categories')
                                .doc(selectedCategoryIdForProducts)
                                .collection('products')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              final products = snapshot.data!.docs;
                              if (products.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'No products available',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  final data = product.data();
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Image.network(
                                          data['image_url'] ?? '',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                          const Icon(Icons.error),
                                        ),
                                        title: Text(
                                          data['description'] ?? 'No name',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            if (data['sub_description'] !=
                                                null &&
                                                data['sub_description']
                                                    .isNotEmpty)
                                              Text(
                                                data['sub_description'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            Text(
                                              '₹ ${data['price']?.toStringAsFixed(2) ?? '0.00'}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.yellow,
                                              ),
                                              onPressed:
                                                  () => editProduct(
                                                selectedCategoryIdForProducts!,
                                                product.id,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed:
                                                  () => deleteProduct(
                                                selectedCategoryIdForProducts!,
                                                product.id,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (index < products.length - 1)
                                        Divider(
                                          color: Colors.grey[400],
                                          thickness: 1,
                                        ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ] else ...[
                        _buildTextField(
                          categoryNameController,
                          'Category Name',
                          Icons.category,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          categoryImageController,
                          'Category Image URL',
                          Icons.image,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: isLoading ? null : addCategoryToFirestore,
                          label: Text(
                            editingCategoryId != null
                                ? "Update Category"
                                : "Save Category",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 32,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData? icon, {
        TextInputType keyboardType = TextInputType.text,
        bool required = true,
        Widget? prefixIcon,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: !isLoading, // Ensure field is enabled unless loading
      decoration: _fieldDecoration(
        label,
      ).copyWith(
        prefixIcon: prefixIcon ?? (icon != null ? Icon(icon) : null),
      ),
      validator:
          (value) =>
      required && (value == null || value.isEmpty)
          ? 'Please enter $label'
          : null,
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87, fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategoryId.isNotEmpty ? selectedCategoryId : null,
      decoration: _fieldDecoration('Select Category'),
      items:
      categories
          .map<DropdownMenuItem<String>>(
            (category) => DropdownMenuItem<String>(
          value: category['id'] as String,
          child: Text(
            category['name']! as String,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      )
          .toList(),
      onChanged: (value) => setState(() => selectedCategoryId = value!),
      validator: (value) => value == null ? 'Please select a category' : null,
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight:
            selectedOption == title ? FontWeight.bold : FontWeight.normal,
            color: selectedOption == title ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}