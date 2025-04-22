import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/dashboard_entity.dart';

// Data source for Firestore operations related to dashboard
class DashboardFirestoreDataSource {
  final FirebaseFirestore _firestore;

  DashboardFirestoreDataSource(this._firestore);

  Future<DashboardEntity> getDashboardData() async {
    try {
      // Fetch all categories
      final categorySnapshot = await _firestore.collection('categories').get();
      final categories = categorySnapshot.docs.map((doc) {
        final data = doc.data();
        // Use doc.id as a fallback if 'category' is null
        final categoryName = data['category'] as String? ?? doc.id;
        return {
          ...data,
          'category': categoryName, // Ensure 'category' key exists
        };
      }).toList();

      // Fetch all products nested under categories
      final productFutures = categories.map((category) async {
        final categoryName = category['category'] as String;
        final productsSnapshot = await _firestore
            .collection('categories')
            .doc(categoryName)
            .collection('products')
            .get();
        return productsSnapshot.docs.map((doc) => doc.data()).toList();
      }).toList();

      final productLists = await Future.wait(productFutures);
      final products = productLists.expand((list) => list).toList();

      // Calculate counts
      final categoryCount = categories.length;
      final productCount = products.length;

      return DashboardEntity(
        categoryCount: categoryCount,
        productCount: productCount,
        categories: categories,
        products: products,
      );
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }
}