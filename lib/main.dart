import 'package:flutter/material.dart';
import 'package:snowjon/pages/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, accentColor: Colors.deepOrange),
    );
  }
}
