import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/show_product_entity.dart';

class ShowProductModel extends ShowProductEntity {
  ShowProductModel({
    required super.id,
    super.description,
    super.sub_description,
    super.image_url,
    required super.category_id,
    required super.created_by,
    required super.timestamp,
  });

  factory ShowProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ShowProductModel(
      id: doc.id,
      description: data['description'],
      sub_description: data['sub_description'],
      image_url: data['image_url'],
      category_id: data['category_id'] ?? '',
      created_by: data['created_by'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'description': description,
      'sub_description': sub_description,
      'image_url': image_url,
      'category_id': category_id,
      'created_by': created_by,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}