import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget{
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SettingsScreenState();

}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
    );
  }
}