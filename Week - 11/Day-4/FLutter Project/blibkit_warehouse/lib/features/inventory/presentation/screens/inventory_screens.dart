import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryScreen extends StatefulWidget {
  static final name = "Inventory";
  const InventoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _stockController = TextEditingController();
  String categoryId = "37wBPJHwCMw6CkD0y12L";

  @override
  void initState() {
    super.initState();
    context.read<InventoryBloc>().add(FetchInventoryEvent(categoryId));
  }

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFA),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Inventory",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, weight: 10, size: 30),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      leading: const Icon(LucideIcons.search),
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFFF7FAFA),
                      ),
                      hintText: "Search...",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        final bloc = context.read<InventoryBloc>();
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext modalContext) {
                            return BlocProvider.value(
                              value: bloc,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Filter by Category",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('categories')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child: Text(
                                                "Error loading categories",
                                              ),
                                            );
                                          }
                                          if (!snapshot.hasData) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          }
                                          final categories = snapshot.data!.docs;
                                          return ListView.builder(
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              final category = categories[index];
                                              final catId = category.id;
                                              final categoryName = category.data()
                                              as Map<String, dynamic>? ??
                                                  {};
                                              return ListTile(
                                                title: Text(
                                                  categoryName['name'] ?? catId,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    categoryId = catId;
                                                  });
                                                  context
                                                      .read<InventoryBloc>()
                                                      .add(
                                                    FetchInventoryEvent(
                                                      catId,
                                                    ),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                trailing: categoryId == catId
                                                    ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                )
                                                    : null,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(LucideIcons.slidersHorizontal),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    "Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<InventoryBloc, InventoryState>(
                builder: (context, state) {
                  if (state is InventoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is InventoryLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      product.imageUrl ??
                                          "https://via.placeholder.com/100",
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.description ?? "No Description",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${product.stock} in Stock",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        product.subDescription ?? "No Details",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price: ₹20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        _stockController.clear();
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding:
                                            EdgeInsets.symmetric(
                                              horizontal:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.1,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.grey[100]!,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Add Stock",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    TextField(
                                                      controller:
                                                      _stockController,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                        prefixIcon: Icon(
                                                          LucideIcons.boxes,
                                                          color: Colors.green,
                                                        ),
                                                        hintText:
                                                        "Enter stock quantity...",
                                                        filled: true,
                                                        fillColor:
                                                        Colors.white70,
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide:
                                                          BorderSide(
                                                            color:
                                                            Colors.green,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                            Colors.red,
                                                          ),
                                                          child: Text("Cancel"),
                                                        ),
                                                        SizedBox(width: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            final newStock =
                                                            int.tryParse(
                                                              _stockController
                                                                  .text,
                                                            );
                                                            if (newStock !=
                                                                null) {
                                                              final updatedProduct =
                                                              InventoryEntity(
                                                                id: product.id,
                                                                description:
                                                                product
                                                                    .description,
                                                                subDescription:
                                                                product
                                                                    .subDescription,
                                                                imageUrl:
                                                                product
                                                                    .imageUrl,
                                                                categoryId:
                                                                product
                                                                    .categoryId,
                                                                timestamp:
                                                                product
                                                                    .timestamp,
                                                                stock: product
                                                                    .stock +
                                                                    newStock,
                                                              );
                                                              context
                                                                  .read<
                                                                  InventoryBloc>()
                                                                  .add(
                                                                UpdateInventoryEvent(
                                                                  updatedProduct,
                                                                  categoryId,
                                                                ),
                                                              );
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style:
                                                          ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                            Colors.green,
                                                            shape:
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                10,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Add Stock",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is InventoryError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("No products available"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}