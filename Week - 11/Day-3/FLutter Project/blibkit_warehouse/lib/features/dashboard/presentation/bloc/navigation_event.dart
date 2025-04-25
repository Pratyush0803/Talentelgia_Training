abstract class NavigationEvent {}

class PageTapped extends NavigationEvent {
  final int index;
  PageTapped(this.index);
}
