import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (_, __) => LoginPage()),
      GoRoute(path: '/signup', builder: (_, __) => SignupPage()),
      GoRoute(path: '/forgot-password', builder: (_, __) => ForgotPasswordPage()),
      GoRoute(path: '/home',builder: (_,__) => DashboardScreen()),
    ],
  );
}
