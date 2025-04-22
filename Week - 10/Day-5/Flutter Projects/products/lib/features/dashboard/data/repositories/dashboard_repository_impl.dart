import '../../domain/entity/dashboard_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../data_sources/dashboard_firestore_data_source.dart';

// Implementation of the dashboard repositories
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardFirestoreDataSource _dataSource;

  DashboardRepositoryImpl(this._dataSource);

  @override
  Future<DashboardEntity> getDashboardData() async {
    try {
      return await _dataSource.getDashboardData();
    } catch (e) {
      throw Exception('Failed to get dashboard data: $e');
    }
  }
}