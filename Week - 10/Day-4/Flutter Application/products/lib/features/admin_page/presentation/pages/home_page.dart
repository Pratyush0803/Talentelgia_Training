import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';
import '../widget/app_bar.dart';
import '../widget/category_form.dart';
import '../widget/category_grid.dart';
import '../widget/product_form.dart';
import '../widget/product_list.dart';
import '../widget/sidebar.dart';

// HomeScreen widget: Main admin interface for managing categories and products
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Form key and text controllers for category and product forms
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final subDescriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final categoryNameController = TextEditingController();
  final categoryImageController = TextEditingController();

  // State variables for selected UI option and category
  String selectedOption = 'Add Products by Category';
  String? selectedCategoryId;

  // Debug logging flag
  static const bool isDebugMode = true;

  void log(String message) {
    if (isDebugMode) {
      print(message);
    }
  }

  @override
  void initState() {
    super.initState();
    // Load categories when the screen initializes
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    descriptionController.dispose();
    subDescriptionController.dispose();
    imageUrlController.dispose();
    categoryNameController.dispose();
    categoryImageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the main UI with BlocConsumer to handle state changes
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        // Handle authentication and error states
        if (state is SignedOut) {
          context.go('/login');
        } else if (state is CategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is CategoryLoaded) {
          log(
            'BlocConsumer: editingCategoryId=${state.editingCategoryId}, editingProductId=${state.editingProductId}',
          );
          if (state.editingCategoryId != null) {
            try {
              final category = state.categories.firstWhere(
                    (cat) => cat.id == state.editingCategoryId,
              );
              categoryNameController.text = category.name;
              categoryImageController.text = category.imageUrl ?? '';
              setState(() {
                selectedOption = 'Add Category';
                selectedCategoryId = null;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category not found')),
              );
              categoryNameController.clear();
              categoryImageController.clear();
            }
          } else if (state.editingProductId != null && state.selectedCategoryId != null) {
            try {
              final product = state.products.firstWhere(
                    (prod) => prod.id == state.editingProductId,
              );
              descriptionController.text = product.description;
              subDescriptionController.text = product.subDescription ?? '';
              imageUrlController.text = product.imageUrl;
              setState(() {
                selectedOption = 'Add Products by Category';
                selectedCategoryId = state.selectedCategoryId;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product not found')),
              );
              descriptionController.clear();
              subDescriptionController.clear();
              imageUrlController.clear();
            }
          } else {
            // Clear form fields when not editing
            if (selectedOption == 'Add Category') {
              categoryNameController.clear();
              categoryImageController.clear();
            } else if (selectedOption == 'Add Products by Category') {
              descriptionController.clear();
              subDescriptionController.clear();
              imageUrlController.clear();
            }
          }
        }
      },
      builder: (context, state) {
        // Extract state data for UI rendering
        final isLoading = state is CategoryLoading;
        final categories = state is CategoryLoaded ? state.categories : <Category>[];
        final products = state is CategoryLoaded ? state.products : <Product>[];
        final editingCategoryId = state is CategoryLoaded ? state.editingCategoryId : null;
        final editingProductId = state is CategoryLoaded ? state.editingProductId : null;

        // Main scaffold with sidebar and content
        return Scaffold(
          body: Row(
            children: [
              Sidebar(
                isLoading: isLoading,
                selectedOption: selectedOption,
                onOptionSelected: (option) {
                  setState(() {
                    selectedOption = option;
                    if (option == 'Add Category') {
                      categoryNameController.clear();
                      categoryImageController.clear();
                    }
                    selectedCategoryId = null;
                  });
                },
                onSignOut: () => context.read<CategoryBloc>().add(SignOutEvent()),
              ),
              VerticalDivider(width: 3, thickness: 2, color: Colors.green[400]),
              Expanded(
                child: Column(
                  children: [
                    CustomAppBar(selectedOption: selectedOption),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildMainContent(
                              context,
                              isLoading,
                              categories,
                              products,
                              editingCategoryId,
                              editingProductId,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Main Content: Renders forms or grids based on the selected option
  Widget _buildMainContent(
      BuildContext context,
      bool isLoading,
      List<Category> categories,
      List<Product> products,
      String? editingCategoryId,
      String? editingProductId,
      ) {
    if (selectedOption == 'Add Products by Category') {
      return ProductForm(
        formKey: _formKey,
        isLoading: isLoading,
        categories: categories,
        editingProductId: editingProductId,
        descriptionController: descriptionController,
        subDescriptionController: subDescriptionController,
        imageUrlController: imageUrlController,
        selectedCategoryId: selectedCategoryId,
        onCategorySelected: (categoryId) {
          setState(() {
            selectedCategoryId = categoryId;
          });
          context.read<CategoryBloc>().add(ViewCategoryEvent(categoryId));
        },
        onSubmit: (categoryId) {
          if (_formKey.currentState!.validate()) {
            if (categoryId == null && categories.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No categories available')),
              );
              return;
            }
            final selectedId = categoryId ?? categories.first.id;
            if (editingProductId == null) {
              context.read<CategoryBloc>().add(
                AddProductEvent(
                  description: descriptionController.text.trim(),
                  subDescription: subDescriptionController.text.trim().isEmpty
                      ? null
                      : subDescriptionController.text.trim(),
                  imageUrl: imageUrlController.text.trim(),
                  categoryId: selectedId,
                ),
              );
            } else {
              context.read<CategoryBloc>().add(
                UpdateProductEvent(
                  id: editingProductId,
                  description: descriptionController.text.trim(),
                  subDescription: subDescriptionController.text.trim().isEmpty
                      ? null
                      : subDescriptionController.text.trim(),
                  imageUrl: imageUrlController.text.trim(),
                  categoryId: selectedId,
                ),
              );
            }
            descriptionController.clear();
            subDescriptionController.clear();
            imageUrlController.clear();
            setState(() {
              selectedOption = 'Category Management';
              selectedCategoryId = null;
            });
          }
        },
        onCancel: editingProductId != null
            ? () {
          context.read<CategoryBloc>().add(CancelEditEvent());
          descriptionController.clear();
          subDescriptionController.clear();
          imageUrlController.clear();
          setState(() {
            selectedOption = 'Category Management';
            selectedCategoryId = null;
          });
        }
            : null,
      );
    } else if (selectedOption == 'Category Management' && selectedCategoryId == null) {
      return CategoryGrid(
        isLoading: isLoading,
        categories: categories,
        onView: (categoryId) {
          setState(() {
            selectedOption = 'Category Management';
            selectedCategoryId = categoryId;
          });
          context.read<CategoryBloc>().add(ViewCategoryEvent(categoryId));
        },
        onEdit: (categoryId) {
          log('Editing category $categoryId');
          context.read<CategoryBloc>().add(StartEditCategoryEvent(categoryId));
          setState(() {
            selectedOption = 'Add Category';
            selectedCategoryId = null;
          });
        },
        onDelete: (categoryId) {
          context.read<CategoryBloc>().add(DeleteCategoryEvent(categoryId));
        },
      );
    } else if (selectedOption == 'Category Management' && selectedCategoryId != null) {
      return ProductList(
        isLoading: isLoading,
        products: products,
        selectedCategoryId: selectedCategoryId!,
        onEdit: (productId) {
          log('ProductList: Editing product $productId, category: $selectedCategoryId');
          context.read<CategoryBloc>().add(
            StartEditProductEvent(productId, selectedCategoryId!),
          );
          setState(() {
            selectedOption = 'Add Products by Category';
          });
        },
        onDelete: (productId) {
          context.read<CategoryBloc>().add(
            DeleteProductEvent(selectedCategoryId!, productId),
          );
        },
      );
    } else {
      return CategoryForm(
        formKey: _formKey,
        isLoading: isLoading,
        editingCategoryId: editingCategoryId,
        nameController: categoryNameController,
        imageController: categoryImageController,
        onSubmit: () {
          if (_formKey.currentState!.validate()) {
            if (editingCategoryId == null) {
              context.read<CategoryBloc>().add(
                AddCategoryEvent(
                  name: categoryNameController.text.trim(),
                  imageUrl: categoryImageController.text.trim(),
                ),
              );
            } else {
              context.read<CategoryBloc>().add(
                UpdateCategoryEvent(
                  id: editingCategoryId,
                  name: categoryNameController.text.trim(),
                  imageUrl: categoryImageController.text.trim(),
                ),
              );
            }
            categoryNameController.clear();
            categoryImageController.clear();
            setState(() {
              selectedOption = 'Category Management';
              selectedCategoryId = null;
            });
          }
        },
        onCancel: editingCategoryId != null
            ? () {
          context.read<CategoryBloc>().add(CancelEditEvent());
          categoryNameController.clear();
          categoryImageController.clear();
          setState(() {
            selectedOption = 'Category Management';
            selectedCategoryId = null;
          });
        }
            : null,
      );
    }
  }
}