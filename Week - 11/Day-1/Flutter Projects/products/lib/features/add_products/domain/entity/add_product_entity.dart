import 'package:equatable/equatable.dart';

class AddProductEntity extends Equatable {
  final String category_id;
  final String description;
  final String? sub_description;
  final String image_url;
  final String created_by;
  final DateTime timestamp;

  const AddProductEntity({
    required this.category_id,
    required this.description,
    this.sub_description,
    required this.image_url,
    required this.created_by,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [category_id, description, sub_description, image_url, created_by, timestamp];
}