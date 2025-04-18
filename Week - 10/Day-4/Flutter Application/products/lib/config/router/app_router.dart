import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:products/features/admin_page/presentation/pages/home_page.dart';
import '../../features/admin_page/presentation/bloc/category_event.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/admin_page/presentation/bloc/category_bloc.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => BlocProvider<AuthBloc>(
          create: (context) => GetIt.instance<AuthBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (_, __) => BlocProvider<CategoryBloc>(
          create: (context) => GetIt.instance<CategoryBloc>()..add(LoadCategoriesEvent()),
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}