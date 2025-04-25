import 'package:blibkit_warehouse/features/inventory/data/inventory_model/inventory_model.dart';
import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<InventoryModel>> getProducts(String categoryId) {
    return _firestore
        .collection('categories')
        .doc(categoryId)
        .collection('products')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => InventoryModel.fromFirestore(doc))
        .toList());
  }

  Future<void> updateProduct(InventoryEntity product) async {
    await _firestore
        .collection('categories')
        .doc(product.categoryId)
        .collection('products')
        .doc(product.id)
        .set({
      'description': product.description,
      'sub_description': product.subDescription,
      'image_url': product.imageUrl,
      'category_id': product.categoryId,
      'timestamp': FieldValue.serverTimestamp(),
      'stock': product.stock,
    }, SetOptions(merge: true));
  }
}