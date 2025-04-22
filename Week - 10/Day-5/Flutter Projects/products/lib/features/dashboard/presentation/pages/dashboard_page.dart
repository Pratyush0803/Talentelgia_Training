import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart' as event;
import '../bloc/dashboard_state.dart';
import '../widgets/sidebar.dart';

class DashboardPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardPage({super.key, required this.navigationShell});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(const event.FetchDashboardData());
  }

  void _onMenuItemTapped(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(
            onMenuItemTapped: _onMenuItemTapped,
            selectedIndex: widget.navigationShell.currentIndex,
          ),
          Expanded(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DashboardError) {
                  return Center(child: Text(state.message));
                } else if (state is DashboardLoaded) {
                  return widget.navigationShell;
                }
                return const Center(child: Text('Loading...'));
              },
            ),
          ),
        ],
      ),
    );
  }
}