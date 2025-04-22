import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/injection.dart';
import '../bloc/add_category_bloc.dart';
import '../bloc/add_category_state.dart';
import '../widget/category_form.dart';

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
    print('AddCategoryPage initialized with categoryData: ${widget.categoryData}');
  }

  void _setFormState(CategoryFormState state) {
    _formState = state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCategoryBloc>(),
      child: BlocConsumer<AddCategoryBloc, AddCategoryState>(
        listener: (context, state) {
          print('BlocConsumer listener received state: $state');
          if (state is AddCategorySuccess && mounted) {
            print('Category operation successful');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Category operation successful!')),
            );
            if (_formKey.currentState != null && _formState != null) {
              print('Attempting to reset form');
              _formKey.currentState!.reset();
              _formState!.resetForm();
            } else {
              print('Form state is null');
            }
            // Pop page after success
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          } else if (state is AddCategoryFailure && mounted) {
            print('Category operation failed: ${state.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
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
                        child: CategoryForm(
                          formKey: _formKey,
                          categoryData: widget.categoryData,
                          onStateCreated: _setFormState,
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