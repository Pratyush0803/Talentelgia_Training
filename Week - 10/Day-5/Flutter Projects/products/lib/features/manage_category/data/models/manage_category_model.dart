import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/manage_category_entity.dart';

class ManageCategoryModel extends ManageCategoryEntity {
  const ManageCategoryModel({
    required super.id,
    required super.name,
    super.image_url,
    super.timestamp,
  });

  factory ManageCategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ManageCategoryModel(
      id: doc.id,
      name: data['name'] as String,
      image_url: data['image_url'] as String? ?? data['imageUrl'] as String?, // Backward compatibility
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image_url': image_url,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : FieldValue.serverTimestamp(),
    };
  }
}