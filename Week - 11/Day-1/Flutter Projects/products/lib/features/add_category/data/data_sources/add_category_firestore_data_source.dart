import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/add_category_model.dart';

class AddCategoryFirestoreDataSource {
  final FirebaseFirestore _firestore;

  AddCategoryFirestoreDataSource(this._firestore);

  Future<String> addCategory(AddCategoryModel category) async {
    final docRef = await _firestore.collection('categories').add(category.toFirestore());
    return docRef.id;
  }

  Future<void> editCategory(String categoryId, AddCategoryModel category) async {
    await _firestore.collection('categories').doc(categoryId).update(category.toFirestore());
  }
}