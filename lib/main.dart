

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'flutter firebase Authentication/Home_Page_AA.dart';
import 'flutter firebase Authentication/SignIn_Page.dart';
import 'flutter firebase crud/Firebase_crud.dart';
import 'flutter xampp crud/_main_Crud_home.dart';

import 'Alarm App/alarm.dart';




var admin_id;

var ip_address ='192.168.29.64';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseAuth auth = FirebaseAuth.instance;
  var isLogin = false;
  User? user;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if(user != null && mounted){
        setState(() {
          isLogin = true;
        });
      }

    });
  }

  void initState() {

    checkIfLogin();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? Home_Page_a() : Sign_In_page(),
    );
  }
}



