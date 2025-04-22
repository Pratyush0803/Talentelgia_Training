import 'package:equatable/equatable.dart';
import '../../domain/entity/dashboard_entity.dart';

// Data models for dashboard summary data and detailed data
class DashboardModel extends Equatable {
  final int categoryCount;
  final int productCount;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> products;

  const DashboardModel({
    required this.categoryCount,
    required this.productCount,
    required this.categories,
    required this.products,
  });

  // Convert models to domain entity
  DashboardEntity toEntity() {
    return DashboardEntity(
      categoryCount: categoryCount,
      productCount: productCount,
      categories: categories,
      products: products,
    );
  }

  // Create models from Firestore data (if needed)
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      categoryCount: json['categoryCount'] ?? 0,
      productCount: json['productCount'] ?? 0,
      categories: List<Map<String, dynamic>>.from(json['categories'] ?? []),
      products: List<Map<String, dynamic>>.from(json['products'] ?? []),
    );
  }

  // Convert models to JSON for Firestore (if needed)
  Map<String, dynamic> toJson() {
    return {
      'categoryCount': categoryCount,
      'productCount': productCount,
      'categories': categories,
      'products': products,
    };
  }

  @override
  List<Object?> get props => [categoryCount, productCount, categories, products];
}