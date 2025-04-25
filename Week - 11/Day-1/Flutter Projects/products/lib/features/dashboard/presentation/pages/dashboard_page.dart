import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../manage_category/presentation/bloc/manage_category_bloc.dart';
import '../../../manage_category/presentation/bloc/manage_category_event.dart';
import '../../../show_products/presentation/bloc/show_product_bloc.dart';
import '../../../show_products/presentation/bloc/show_product_event.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart' as event;
import '../bloc/dashboard_state.dart';
import '../widgets/sidebar.dart';
import '../../../../config/injection.dart';
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
    // Re-fetch data when switching branches
    if (index == 0) {
      context.read<ShowProductBloc>().add(FetchProductsEvent('')); // Default category, adjust as needed
    } else if (index == 2) {
      context.read<ManageCategoryBloc>().add(FetchCategoriesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DashboardBloc>()..add(const event.FetchDashboardData())),
        BlocProvider(create: (context) => getIt<ManageCategoryBloc>()..add(FetchCategoriesEvent())),
        BlocProvider(create: (context) => getIt<ShowProductBloc>()..add(FetchProductsEvent(''))), // Default fetch
      ],
      child: Scaffold(
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
      ),
    );
  }
}