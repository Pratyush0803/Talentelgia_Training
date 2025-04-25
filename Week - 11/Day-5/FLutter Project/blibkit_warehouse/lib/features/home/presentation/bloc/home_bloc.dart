import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_location_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLocationUsecase getLocation;

  HomeBloc({required this.getLocation}) : super(HomeInitial()) {
    on<LoadLocationEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final location = await getLocation();
        emit(HomeLoaded(location));
      } catch (e) {
        emit(HomeError("Failed to load location"));
      }
    });
  }
}
