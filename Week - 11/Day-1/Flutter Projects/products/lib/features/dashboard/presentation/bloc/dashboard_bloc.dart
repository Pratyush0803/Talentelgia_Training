import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_dashboard_data_use_case.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

// BLoC for managing dashboard state and events
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase _getDashboardDataUseCase;

  DashboardBloc(this._getDashboardDataUseCase) : super(DashboardInitial()) {
    on<FetchDashboardData>(_onFetchDashboardData);
  }

  Future<void> _onFetchDashboardData(
      FetchDashboardData event,
      Emitter<DashboardState> emit,
      ) async {
    emit(DashboardLoading());
    try {
      final data = await _getDashboardDataUseCase();
      emit(DashboardLoaded(data));
    } catch (e) {
      emit(DashboardError('Failed to load dashboard data: $e'));
    }
  }
}