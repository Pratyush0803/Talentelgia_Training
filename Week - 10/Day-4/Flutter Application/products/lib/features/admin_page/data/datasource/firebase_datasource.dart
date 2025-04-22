import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';

class FirebaseDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseDataSource({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      return snapshot.docs.map((doc) => CategoryModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      final querySnapshot = await _firestore
          .collection('categories')
          .where('name', isEqualTo: category.name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        throw Exception('A category with this name already exists');
      }
      final data = category.toFirestore()..['created_by'] = user.uid;
      await _firestore.collection('categories').add(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      final querySnapshot = await _firestore
          .collection('categories')
          .where('name', isEqualTo: category.name)
          .get();
      if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.first.id != category.id) {
        throw Exception('A category with this name already exists');
      }
      final data = category.toFirestore()..['created_by'] = user.uid;
      await _firestore.collection('categories').doc(category.id).update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final productsSnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .get();
      for (final doc in productsSnapshot.docs) {
        await doc.reference.delete();
      }
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  Future<void> addProduct(ProductModel product, String categoryId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      final querySnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .where('description', isEqualTo: product.description)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        throw Exception('A product with this description already exists in this category');
      }
      final data = product.toFirestore()
        ..['created_by'] = user.uid
        ..['category_id'] = categoryId;
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .add(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateProduct(ProductModel product, String categoryId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      final querySnapshot = await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .where('description', isEqualTo: product.description)
          .get();
      if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.first.id != product.id) {
        throw Exception('A product with this description already exists in this category');
      }
      final data = product.toFirestore()
        ..['created_by'] = user.uid
        ..['category_id'] = categoryId;
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(product.id)
          .update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteProduct(String categoryId, String productId) async {
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Stream<List<ProductModel>> getProducts(String categoryId) {
    try {
      return _firestore
          .collection('categories')
          .doc(categoryId)
          .collection('products')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList());
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}