import 'package:equatable/equatable.dart';
import '../../domain/entity/add_category_entity.dart';

abstract class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object?> get props => [];
}

class AddNewCategoryEvent extends AddCategoryEvent {
  final AddCategoryEntity category;

  const AddNewCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateCategoryEvent extends AddCategoryEvent {
  final String categoryId;
  final AddCategoryEntity category;

  const UpdateCategoryEvent({
    required this.categoryId,
    required this.category,
  });

  @override
  List<Object?> get props => [categoryId, category];
}