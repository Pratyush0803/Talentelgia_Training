abstract class OrderState{}

class OrderInitial extends OrderState{}

class OrderLoading extends OrderState{}

class OrderLoaded extends OrderState{}

class HomeError extends OrderState{
  final String message;
  HomeError(this.message);
}
