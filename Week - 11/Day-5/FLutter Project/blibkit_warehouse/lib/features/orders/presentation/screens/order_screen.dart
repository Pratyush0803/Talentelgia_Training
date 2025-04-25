import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static final name = "Order";
  const OrderScreen({super.key});

  @override
  State<StatefulWidget> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Orders",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        
      ),
    );
  }
}
