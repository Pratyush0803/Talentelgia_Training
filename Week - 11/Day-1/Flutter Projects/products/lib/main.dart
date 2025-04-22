import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products/features/show_products/presentation/bloc/show_product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/injection.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/add_products/presentation/bloc/add_product_bloc.dart';
import 'features/manage_category/presentation/bloc/manage_category_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Main: Initializing Firebase');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Main: Firebase initialized');
  print('Main: Configuring dependencies');
  await di.configureDependencies();
  print('Main: Dependencies configured');
  final sharedPrefs = await SharedPreferences.getInstance();
  print('Main: SharedPreferences initialized, userId=${sharedPrefs.getString('userId')}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final authBloc = di.getIt<AuthBloc>();
            print('Main: Triggering CheckLoginStatus');
            authBloc.add(CheckLoginStatus());
            return authBloc;
          },
        ),
        BlocProvider<DashboardBloc>(
          create: (_) => di.getIt<DashboardBloc>(),
        ),
        BlocProvider<AddProductBloc>(
          create: (_) => di.getIt<AddProductBloc>(),
        ),
        BlocProvider<ManageCategoryBloc>(
          create: (_) => di.getIt<ManageCategoryBloc>(),
        ),
        BlocProvider<ShowProductBloc>(
          create: (_) => di.getIt<ShowProductBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Admin Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoTextTheme(),
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 4,
          ),
        ),
        routerConfig: di.getIt<GoRouter>(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}