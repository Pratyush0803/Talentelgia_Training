import 'package:blibkit_warehouse/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blibkit_warehouse/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:blibkit_warehouse/features/auth/presentation/pages/login_page.dart';
import 'package:blibkit_warehouse/features/auth/presentation/pages/signup_page.dart';
import 'package:blibkit_warehouse/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:blibkit_warehouse/features/home/presentation/bloc/home_bloc.dart';
import 'package:blibkit_warehouse/features/home/presentation/screens/home_screen.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:blibkit_warehouse/features/inventory/presentation/screens/inventory_screens.dart';
import 'package:blibkit_warehouse/features/orders/presentation/screens/order_screen.dart';
import 'package:blibkit_warehouse/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:blibkit_warehouse/features/settings/presentation/screens/settings_screen.dart';
import 'package:blibkit_warehouse/features/settings/presentation/widgets/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../injections.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login',
        name: LoginPage.name,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: SignupPage.name,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignupPage(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: ForgotPasswordPage.name,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const ForgotPasswordPage(),
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: HomeScreen.name,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<HomeBloc>(),
                  child: const HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inventory',
                name: InventoryScreen.name,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<InventoryBloc>(),
                  child: const InventoryScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/orders',
                name: OrderScreen.name,
                builder: (context, state) => const OrderScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: SettingsScreen.name,
                builder: (context, state) => BlocProvider(
                  create: (_) => sl<SettingsBloc>(),
                  child: const SettingsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'notification',
                    name: NotificationScreen.name,
                    builder: (context, state) => NotificationScreen(),
                  ),
                ]
              ),


            ],

          ),
        ],
      ),
    ],
  );
}