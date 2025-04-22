import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.description,
    super.subDescription,
    required super.imageUrl,
    required super.timestamp,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      description: data['description'] as String,
      subDescription: data['sub_description'] as String?,
      imageUrl: data['image_url'] as String,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{
      'description': description,
      'image_url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };
    if (subDescription != null) {
      data['sub_description'] = subDescription;
    }
    return data;
  }
}