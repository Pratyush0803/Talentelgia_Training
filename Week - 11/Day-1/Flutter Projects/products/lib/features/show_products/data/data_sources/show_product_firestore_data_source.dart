import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/show_product_entity.dart';
import '../models/show_product_model.dart';

class ShowProductFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ShowProductModel>> getProductsByCategory(String categoryId) async {
    print('Querying products for categoryId: $categoryId');
    final querySnapshot = await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .get();
    return querySnapshot.docs
        .map((doc) => ShowProductModel.fromFirestore(doc))
        .toList();
  }

  Future<void> deleteProduct(String productId, String categoryId) async {
    print('Deleting product with ID: $productId in category: $categoryId');
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc(productId)
        .delete();
  }

  Future<void> updateProduct(ShowProductEntity product) async {
    print('Updating product with ID: ${product.id}');
    await _firestore
        .collection('categories')
        .doc(product.category_id)
        .collection('products')
        .doc(product.id)
        .set({
      'description': product.description,
      'sub_description': product.sub_description,
      'image_url': product.image_url,
      'category_id': product.category_id,
      'created_by': product.created_by,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
