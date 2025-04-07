import 'package:bloc_counter_app/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/counter.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => Counter(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    ),
  );
}
