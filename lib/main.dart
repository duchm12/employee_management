import 'package:flutter/material.dart';
import 'package:employee_management/src/screens/home/home_view.dart';

void main() {
  runApp(const ManagementApp());
}

class ManagementApp extends StatelessWidget {
  const ManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeRoute(),
    );
  }
}
