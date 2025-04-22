import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/manage_category_model.dart';

class ManageCategoryFirestoreDataSource {
  final FirebaseFirestore _firestore;

  ManageCategoryFirestoreDataSource(this._firestore);

  Stream<List<ManageCategoryModel>> getCategories() {
    print('Fetching categories from Firestore...');
    return _firestore.collection('categories').snapshots().map((snapshot) {
      print('Firestore snapshot received with ${snapshot.docs.length} documents');
      return snapshot.docs.map((doc) => ManageCategoryModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  Future<void> editCategory(String categoryId, ManageCategoryModel category) async {
    print('Updating category $categoryId in Firestore with data: ${category.toFirestore()}');
    await _firestore.collection('categories').doc(categoryId).update(category.toFirestore());
  }
}