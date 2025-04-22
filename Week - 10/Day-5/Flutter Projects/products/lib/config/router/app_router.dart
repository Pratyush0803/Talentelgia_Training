import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/add_category/presentation/pages/add_category_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/add_products/presentation/pages/add_product_page.dart';
import '../../features/manage_category/presentation/page/category_list_page.dart';
import '../injection.dart' as di;

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const addProducts = '/home/add-products';
  static const addCategory = '/home/add-category';
  static const manageCategories = '/home/manage-categories';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  redirect: (context, state) async {
    final sharedPrefs = await di.getIt.getAsync<SharedPreferences>();
    final userId = sharedPrefs.getString('userId');
    final firebaseUser = di.getIt<FirebaseAuth>().currentUser;

    final isLoggedIn = userId != null && firebaseUser != null && firebaseUser.uid == userId;
    final isLoginPath = state.matchedLocation == AppRoutes.login;

    print('Router: isLoggedIn=$isLoggedIn, userId=$userId, firebaseUser=${firebaseUser?.uid}, currentPath=${state.matchedLocation}');
    if (!isLoggedIn && !isLoginPath) {
      print('Router: Redirecting to /login');
      return AppRoutes.login;
    }
    if (isLoggedIn && isLoginPath) {
      print('Router: Redirecting to /home/add-products');
      return AppRoutes.addProducts;
    }
    if (state.matchedLocation == AppRoutes.home && state.fullPath != AppRoutes.addProducts) {
      print('Router: Redirecting /home to /home/add-products');
      return AppRoutes.addProducts;
    }
    print('Router: No redirect needed');
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
              builder: (context, state) => const AddProductPage(),
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
          ],
        ),
      ],
    ),
  ],
);