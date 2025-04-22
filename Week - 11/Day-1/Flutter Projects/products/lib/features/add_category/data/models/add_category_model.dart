import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/add_category_entity.dart';

class AddCategoryModel extends AddCategoryEntity {
  final String id;

  const AddCategoryModel({
    required this.id,
    required super.name,
    super.image_url,
    super.timestamp,
  });

  factory AddCategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AddCategoryModel(
      id: doc.id,
      name: data['name'] as String,
      image_url: data['image_url'] as String? ?? data['imageUrl'] as String?,
      timestamp: _parseFirestoreTimestamp(data['timestamp']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'image_url': image_url,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  static DateTime? _parseFirestoreTimestamp(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is DateTime) {
      return value;
    }
    return null;
  }
}
