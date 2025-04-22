import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../bloc/navigation_bloc.dart';
import '../bloc/navigation_event.dart';
import '../bloc/navigation_state.dart';

class DashboardScreen extends StatelessWidget {
  final List<Widget> pages = const [
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: pages[state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index) =>
                  context.read<NavigationBloc>().add(PageTapped(index)),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey[600],
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.tableCellsLarge),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.store),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userGear),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
