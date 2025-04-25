import 'package:blibkit_warehouse/features/inventory/domain/entity/inventory_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryModel extends InventoryEntity {
  InventoryModel({
    required super.id,
    super.description,
    super.subDescription,
    super.imageUrl,
    required super.categoryId,
    required super.timestamp,
    required super.stock
  });

  factory InventoryModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return InventoryModel(id: doc.id,
      description: data['description'],
      subDescription: data['sub_description'],
      imageUrl: data['image_url'],
      categoryId: data['category_id'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate().toIso8601String() ?? DateTime.now().toIso8601String(),
      stock: data['stock'] ?? 0,

    );
  }
  Map<String, dynamic> toFirestore(){
    return {
      'description': description,
      'sub_description':subDescription,
      'image_url': imageUrl,
      'category_id': categoryId,
      'timestamp': FieldValue.serverTimestamp(),
      'stock': stock,
    };
  }
}
