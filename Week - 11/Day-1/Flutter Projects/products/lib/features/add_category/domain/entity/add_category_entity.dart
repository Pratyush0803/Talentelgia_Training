import 'package:equatable/equatable.dart';

class AddCategoryEntity extends Equatable {
  final String name;
  final String? image_url;
  final DateTime? timestamp;

  const AddCategoryEntity({
    required this.name,
    this.image_url,
    this.timestamp,
  });

  @override
  List<Object?> get props => [name, image_url, timestamp];
}
