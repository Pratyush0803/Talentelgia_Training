import 'package:equatable/equatable.dart';

class ManageCategoryEntity extends Equatable {
  final String id;
  final String name;
  final String? image_url;
  final DateTime? timestamp;

  const ManageCategoryEntity({
    required this.id,
    required this.name,
    this.image_url,
    this.timestamp,
  });

  @override
  List<Object?> get props => [id, name, image_url, timestamp];
}