import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../../config/router/app_router.dart';
import '../bloc/manage_category_bloc.dart';
import '../bloc/manage_category_event.dart';
import '../bloc/manage_category_state.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ManageCategoryBloc>();
    bloc.add(FetchCategoriesEvent());
    print('CategoryListPage initialized and FetchCategoriesEvent dispatched');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ManageCategoryBloc>()..add(FetchCategoriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Categories'),
          backgroundColor: Colors.green[700],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF7F3F9), Color(0xFFF5F5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocBuilder<ManageCategoryBloc, ManageCategoryState>(
            builder: (context, state) {
              if (state is ManageCategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ManageCategoryError) {
                return Center(child: Text(state.message));
              } else if (state is ManageCategoryLoaded) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: state.categories.map((category) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width > 100
                            ? 290
                            : MediaQuery.of(context).size.width > 600
                            ? 320
                            : double.infinity,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: Colors.green[50],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    category.image_url ?? '',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.visibility, color: Colors.green),
                                            onPressed: () {
                                              print('View clicked for ${category.name}');
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            onPressed: () {
                                              print('Edit clicked for ${category.name} with data: {categoryId: ${category.id}, name: ${category.name}, image_url: ${category.image_url}}');
                                              final extraData = {
                                                'categoryId': category.id,
                                                'name': category.name,
                                                'image_url': category.image_url,
                                              };
                                              print('Pushing to ${AppRoutes.addCategory} with extra: $extraData');
                                              context.push(
                                                AppRoutes.addCategory,
                                                extra: extraData,
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              context.read<ManageCategoryBloc>().add(
                                                DeleteCategoryEvent(category.id),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return const Center(child: Text('No categories available'));
            },
          ),
        ),
      ),
    );
  }
}