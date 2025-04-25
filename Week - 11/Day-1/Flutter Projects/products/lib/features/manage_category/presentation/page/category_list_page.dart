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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) return;
    final bloc = context.read<ManageCategoryBloc>();
    if (bloc.state is! ManageCategoryLoaded) {
      bloc.add(FetchCategoriesEvent());
    }
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
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB2DFDB), Color(0xFF81C784)],
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
                          color: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: SizedBox(
                              height: 140,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            width: 100,
                                            height: 10,
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.visibility, color: Colors.green),
                                                    onPressed: () {
                                                      print('View clicked for ${category.name}');
                                                      final extraData = {
                                                        'categoryId': category.id,
                                                        'categoryName': category.name,
                                                      };
                                                      context.push(
                                                        AppRoutes.viewProducts,
                                                        extra: extraData,
                                                      );
                                                    },
                                                  ),
                                                  const Text(
                                                    'View\nCategory',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                                    onPressed: () {
                                                      final extraData = {
                                                        'categoryId': category.id,
                                                        'name': category.name,
                                                        'image_url': category.image_url,
                                                      };
                                                      context.push(
                                                        AppRoutes.addCategory,
                                                        extra: extraData,
                                                      );
                                                    },
                                                  ),
                                                  const Text(
                                                    'Edit\nCategory',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(Icons.delete, color: Colors.red),
                                                    onPressed: () {
                                                      context.read<ManageCategoryBloc>().add(
                                                        DeleteCategoryEvent(category.id),
                                                      );
                                                    },
                                                  ),
                                                  const Text(
                                                    'Delete\nCategory',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ],
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