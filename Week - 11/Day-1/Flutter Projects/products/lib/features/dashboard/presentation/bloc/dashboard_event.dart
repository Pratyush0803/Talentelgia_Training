import 'package:equatable/equatable.dart';

// Abstract base class for dashboard events
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

// Event to trigger fetching dashboard data
class FetchDashboardData extends DashboardEvent {
  const FetchDashboardData();
}