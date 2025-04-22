import 'package:equatable/equatable.dart';

abstract class ManageCategoryEvent extends Equatable {
  const ManageCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends ManageCategoryEvent {}

class DeleteCategoryEvent extends ManageCategoryEvent {
  final String categoryId;

  const DeleteCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class EditCategoryEvent extends ManageCategoryEvent {
  final String categoryId;
  final String newName;
  final String? newImageUrl;

  const EditCategoryEvent({
    required this.categoryId,
    required this.newName,
    this.newImageUrl,
  });

  @override
  List<Object?> get props => [categoryId, newName, newImageUrl];
}