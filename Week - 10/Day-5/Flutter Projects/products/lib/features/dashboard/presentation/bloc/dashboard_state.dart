import 'package:equatable/equatable.dart';
import '../../domain/entity/dashboard_entity.dart';

// Abstract base class for dashboard states
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

// Initial state before any action
class DashboardInitial extends DashboardState {}

// Loading state while fetching data
class DashboardLoading extends DashboardState {}

// Loaded state with dashboard data
class DashboardLoaded extends DashboardState {
  final DashboardEntity data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

// Error state when data fetching fails
class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}