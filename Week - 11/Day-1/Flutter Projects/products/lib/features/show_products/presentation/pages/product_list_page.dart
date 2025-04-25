import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../../config/router/app_router.dart';
import '../bloc/show_product_bloc.dart';
import '../bloc/show_product_event.dart';
import '../bloc/show_product_state.dart';

class ProductListPage extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const ProductListPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final ShowProductBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ShowProductBloc>();
    _bloc.add(FetchProductsEvent(widget.categoryId)); // Always fetch on init
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) return;
    if (_bloc.state is! ShowProductLoaded) {
      _bloc.add(FetchProductsEvent(widget.categoryId));
    }
    // Listen for navigation changes to refresh
    GoRouter.of(context).routerDelegate.addListener(() {
      if (!mounted) return;
      final currentPath = GoRouter.of(context).routeInformationProvider.value.uri.path;
      final queryParams = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;
      if (currentPath == '/home/manage-categories/products' && queryParams['categoryId'] == widget.categoryId) {
        print('Navigated back to ProductListPage, refreshing with categoryId: ${widget.categoryId}');
        _bloc.add(FetchProductsEvent(widget.categoryId));
      }
    });
  }

  @override
  void dispose() {
    GoRouter.of(context).routerDelegate.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Products - ${widget.categoryName}'),
          backgroundColor: Colors.green[800],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          elevation: 4,
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
          child: BlocBuilder<ShowProductBloc, ShowProductState>(
            bloc: _bloc,
            builder: (context, state) {
              print('ProductListPage state: $state'); // Debug log
              if (state is ShowProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShowProductError) {
                return Center(child: Text(state.message));
              } else if (state is ShowProductLoaded) {
                final products = state.products;
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: products.map((product) {
                      final cardWidth = MediaQuery.of(context).size.width > 600 ? 330.0 : 300.0;
                      return SizedBox(
                        height: 160,
                        width: cardWidth,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.image_url ?? '',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image, size: 24),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.description ?? 'No description',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            product.sub_description ?? 'No sub-description',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit, color: Colors.blue, size: 22),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  print('Navigating to edit with extraData: {id: ${product.id}, description: ${product.description}, sub_description: ${product.sub_description}, image_url: ${product.image_url}, category_id: ${product.category_id}, created_by: ${product.created_by}, timestamp: ${product.timestamp}, isEdit: true}');
                                                  final extraData = {
                                                    'id': product.id,
                                                    'description': product.description,
                                                    'sub_description': product.sub_description,
                                                    'image_url': product.image_url,
                                                    'category_id': product.category_id,
                                                    'created_by': product.created_by,
                                                    'timestamp': product.timestamp,
                                                    'isEdit': true,
                                                  };
                                                  context.push(AppRoutes.addProducts, extra: extraData);
                                                },
                                              ),
                                              const Text(
                                                'Edit Product',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete, color: Colors.red, size: 22),
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  _bloc.add(DeleteProductEvent(product.id, widget.categoryId));
                                                },
                                              ),
                                              const Text(
                                                'Delete Product',
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
                      );
                    }).toList(),
                  ),
                );
              }
              return const Center(child: Text('No products available'));
            },
          ),
        ),
      ),
    );
  }
}