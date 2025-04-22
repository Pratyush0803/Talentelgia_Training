import '../entity/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

// Use case to fetch dashboard data
class GetDashboardDataUseCase {
  final DashboardRepository _repository;

  GetDashboardDataUseCase(this._repository);

  Future<DashboardEntity> call() async {
    final categories = await _repository.getDashboardData();
    return DashboardEntity(
      categoryCount: categories.categoryCount,
      productCount: categories.productCount,
      categories: categories.categories,
      products: categories.products,
    );
  }
}