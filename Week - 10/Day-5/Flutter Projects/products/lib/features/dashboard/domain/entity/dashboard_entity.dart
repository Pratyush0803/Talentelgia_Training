import 'package:equatable/equatable.dart';

// Domain entity for dashboard summary data and category details
class DashboardEntity extends Equatable {
  final int categoryCount;
  final int productCount;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> products;

  const DashboardEntity({
    required this.categoryCount,
    required this.productCount,
    required this.categories,
    required this.products,
  });

  @override
  List<Object?> get props => [categoryCount, productCount, categories, products];
}