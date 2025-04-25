import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/injection.dart';
import '../../../manage_category/domain/entity/manage_category_entity.dart';
import '../../../manage_category/presentation/bloc/manage_category_bloc.dart';
import '../../../manage_category/presentation/bloc/manage_category_event.dart';
import '../../../manage_category/presentation/bloc/manage_category_state.dart';

class ManageCategoriesWidget extends StatelessWidget {
  const ManageCategoriesWidget({super.key});

  void _showEditDialog(BuildContext context, ManageCategoryEntity category) {
    final TextEditingController nameController =
    TextEditingController(text: category.name);
    final TextEditingController imageUrlController =
    TextEditingController(text: category.image_url ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newName = nameController.text.trim();
              final newImageUrl = imageUrlController.text.trim().isEmpty
                  ? null
                  : imageUrlController.text.trim();
              if (newName.isNotEmpty) {
                context.read<ManageCategoryBloc>().add(
                  EditCategoryEvent(
                    categoryId: category.id,
                    newName: newName,
                    newImageUrl: newImageUrl,
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.green[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.green[700],
                child: const Text(
                  'Manage Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocProvider(
                create: (context) => getIt<ManageCategoryBloc>(),
                child: BlocBuilder<ManageCategoryBloc, ManageCategoryState>(
                  builder: (context, state) {
                    if (state is ManageCategoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ManageCategoryError) {
                      return Center(child: Text(state.message));
                    } else if (state is ManageCategoryLoaded) {
                      final categories = state.categories;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  category.image_url ?? '',
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, color: Colors.red);
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.visibility, color: Colors.green),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('View ${category.name}')),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        _showEditDialog(context, category);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        context
                                            .read<ManageCategoryBloc>()
                                            .add(DeleteCategoryEvent(category.id));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text('No data available'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}