import 'package:equatable/equatable.dart';

class AddProductEntity extends Equatable {
  final String category;
  final String description;
  final String? subDescription;
  final String imageUrl;

  const AddProductEntity({
    required this.category,
    required this.description,
    this.subDescription,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [category, description, subDescription, imageUrl];
}