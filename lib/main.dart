import 'package:flutter/material.dart';
import 'Main Screen.dart';
import 'flutter xampp crud/homepage.dart';
import 'flutter xampp crud/splashscreen.dart';

var ip_address ='192.168.29.64';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomePage(),
    );
  }
}

