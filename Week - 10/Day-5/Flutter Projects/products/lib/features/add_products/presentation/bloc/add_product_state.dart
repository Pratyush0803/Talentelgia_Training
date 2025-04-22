import 'package:equatable/equatable.dart';

// Abstract base class for add product states
abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object?> get props => [];
}

// Initial state
class AddProductInitial extends AddProductState {}

// Loading state
class AddProductLoading extends AddProductState {}

// Success state
class AddProductSuccess extends AddProductState {}

// Failure state
class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure(this.message);

  @override
  List<Object?> get props => [message];
}