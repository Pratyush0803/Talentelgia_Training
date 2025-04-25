import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget{
  static final name = "Notfication";
  const NotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() => NotificationScreenState();
  }

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
