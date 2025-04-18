import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/category_entity.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.timestamp,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      name: data['name'] as String,
      imageUrl: data['image_url'] as String?,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image_url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}