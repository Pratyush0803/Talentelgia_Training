import 'package:flutter/material.dart';
import 'package:named_routing/models/counter_model/counter_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Home Screen",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context , counter, child){
            return Text(
              'Count: ${counter.count}',
              style: TextStyle(fontSize: 30),
            );
          }

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
          foregroundColor: Colors.white,
          onPressed: ()=> context.read<CounterModel>().increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}