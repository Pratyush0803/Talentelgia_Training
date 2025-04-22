import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/injection.dart';
import '../../../manage_category/presentation/bloc/manage_category_bloc.dart';
import '../../../manage_category/presentation/bloc/manage_category_event.dart';
import '../bloc/add_category_bloc.dart';
import '../bloc/add_category_state.dart';
import '../widget/category_form.dart';
import '../../../../config/router/app_router.dart';

class AddCategoryPage extends StatefulWidget {
  final Map<String, dynamic>? categoryData;

  const AddCategoryPage({super.key, this.categoryData});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  CategoryFormState? _formState;

  @override
  void initState() {
    super.initState();
    debugPrint('AddCategoryPage initialized with categoryData: ${widget.categoryData}');
  }

  void _setFormState(CategoryFormState state) {
    _formState = state;
  }

  void _safePop(BuildContext context) {
    debugPrint('Attempting to pop AddCategoryPage. Can pop: ${Navigator.canPop(context)}');
    if (Navigator.canPop(context)) {
      try {
        Navigator.of(context).pop();
        debugPrint('Successfully popped AddCategoryPage');
      } catch (e, stackTrace) {
        debugPrint('Error popping AddCategoryPage: $e\n$stackTrace');
        Navigator.of(context).pushReplacementNamed(AppRoutes.manageCategories);
      }
    } else {
      debugPrint('Cannot pop: Navigation stack is empty. Redirecting to safe route.');
      Navigator.of(context).pushReplacementNamed(AppRoutes.manageCategories);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCategoryBloc>(),
      child: BlocConsumer<AddCategoryBloc, AddCategoryState>(
        listener: (context, state) {
          debugPrint('BlocConsumer listener received state: $state');
          if (state is AddCategorySuccess && mounted) {
            final isEdit = widget.categoryData != null;
            debugPrint('Category operation successful: ${isEdit ? 'Updated' : 'Added'}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(isEdit ? 'Category updated successfully!' : 'Category added successfully!'),
                duration: const Duration(seconds: 2),
              ),
            );
            if (!isEdit && _formKey.currentState != null && _formState != null) {
              debugPrint('Resetting form after add');
              _formKey.currentState!.reset();
              _formState!.resetForm();
            }
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _safePop(context);
                // Trigger refresh in CategoryListPage
                final bloc = BlocProvider.of<ManageCategoryBloc>(context, listen: false);
                bloc.add(FetchCategoriesEvent());
              } else {
                debugPrint('Widget not mounted, skipping pop');
              }
            });
          } else if (state is AddCategoryFailure && mounted) {
            debugPrint('Category operation failed: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed: ${state.message}'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.categoryData != null ? 'Edit Category' : 'Add Category'),
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
                        child: Stack(
                          children: [
                            CategoryForm(
                              formKey: _formKey,
                              categoryData: widget.categoryData,
                              onStateCreated: _setFormState,
                            ),
                            if (state is AddCategoryLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}