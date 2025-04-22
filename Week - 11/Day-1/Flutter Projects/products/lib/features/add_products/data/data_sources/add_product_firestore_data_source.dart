import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/add_product_entity.dart';

// Data source for Firestore operations related to adding products
class AddProductFirestoreDataSource {
  final FirebaseFirestore _firestore;

  AddProductFirestoreDataSource(this._firestore);

  Future<void> addProduct(AddProductEntity product) async {
    await _firestore
        .collection('categories')
        .doc(product.category_id)
        .collection('products')
        .add({
      'description': product.description,
      'sub_description': product.sub_description,
      'image_url': product.image_url,
      'created_by': product.created_by,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> editProduct(String categoryId, String productId, AddProductEntity product) async {
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc(productId)
        .update({
      'description': product.description,
      'sub_description': product.sub_description,
      'image_url': product.image_url,
      'created_by': product.created_by,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteProduct(String categoryId, String productId) async {
    await _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .doc(productId)
        .delete();
  }
}