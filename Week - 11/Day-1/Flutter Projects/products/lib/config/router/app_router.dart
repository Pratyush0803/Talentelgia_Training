import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/add_category/presentation/pages/add_category_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/add_products/presentation/pages/add_product_page.dart';
import '../../features/manage_category/presentation/page/category_list_page.dart';
import '../../features/show_products/presentation/pages/product_list_page.dart';
import '../../features/show_products/presentation/bloc/show_product_bloc.dart';
import '../injection.dart' as di;

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const addProducts = '/home/add-products';
  static const addCategory = '/home/add-category';
  static const manageCategories = '/home/manage-categories';
  static const viewProducts = '/home/manage-categories/products';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (context, state) async {
    final sharedPrefs = await di.getIt.getAsync<SharedPreferences>();
    final userId = sharedPrefs.getString('userId');
    final firebaseUser = await FirebaseAuth.instance.authStateChanges().first;

    final isLoggedIn = userId != null && firebaseUser != null && firebaseUser.uid == userId;
    final isLoginPath = state.matchedLocation == AppRoutes.login;

    if (!isLoggedIn && !isLoginPath) return AppRoutes.login;
    if (isLoggedIn && isLoginPath) return AppRoutes.addProducts;
    if (state.matchedLocation == AppRoutes.home) return AppRoutes.addProducts;
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          DashboardPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.addProducts,
              name: 'addProduct',
              builder: (context, state) {
                // Retrieve extra data passed during navigation
                final extraData = state.extra as Map<String, dynamic>?;
                return AddProductPage(extraData: extraData);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.addCategory,
              name: 'addCategory',
              builder: (context, state) => AddCategoryPage(
                categoryData: state.extra as Map<String, dynamic>?,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.manageCategories,
              name: 'manageCategories',
              builder: (context, state) => const CategoryListPage(),
            ),
            GoRoute(
              path: AppRoutes.viewProducts,
              name: 'viewProducts',
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return BlocProvider<ShowProductBloc>(
                  create: (context) => di.getIt<ShowProductBloc>(),
                  child: ProductListPage(
                    categoryId: extra?['categoryId'] as String? ?? '',
                    categoryName: extra?['categoryName'] as String? ?? 'Unknown Category',
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);