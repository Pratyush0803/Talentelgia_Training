import '../../domain/entity/home_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeEntity location;

  HomeLoaded(this.location);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
