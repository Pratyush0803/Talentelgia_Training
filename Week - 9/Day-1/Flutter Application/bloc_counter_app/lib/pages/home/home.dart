import 'package:bloc_counter_app/counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Counter Screen",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder<Counter, int>(
        builder:
            (context, count) => Center(
              child: Text(
                "$count",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            onPressed: () => context.read<Counter>().increment(),
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
            child: Icon(Icons.remove),
            onPressed: () => context.read<Counter>().decrement(),
          ),
        ],
      ),
    );
  }
}
