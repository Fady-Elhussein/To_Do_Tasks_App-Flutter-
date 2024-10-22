import 'package:flutter/material.dart';
import 'package:todoapp/layout/homelayoutscreen.dart';
void main() {
  
  runApp(todoapp());
}
class todoapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do Tasks',
      home: homelayoutscreen(),
    );
  }
}