
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xampp_crud/flutter%20firebase%20Authentication/phone.dart';

import 'SignIn_Page.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';









class Home_Page_a extends StatefulWidget {
  const Home_Page_a({Key? key}) : super(key: key);

  @override
  _Home_Page_aState createState() => _Home_Page_aState();
}

class _Home_Page_aState extends State<Home_Page_a> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home_Page"),
      actions: [
        TextButton(onPressed: ()async{
              await auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  Sign_In_page()), (Route<dynamic> route) => false);

        },
            child: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 19),)),
        SizedBox(width: 20,),
      ],
      ),
      body: ListView(
        children: [
          // auth.currentUser!.emailVerified?SizedBox(height: 1,):
          //     Text("${auth.currentUser!.email!} not verified"),
          // SizedBox(
          //   height: 150,
          // ),

//          Text(auth.currentUser!.email!),
          Text(auth.currentUser!.emailVerified ? "email verified" : "email not verified"),
          auth.currentUser!.emailVerified
              ? SizedBox(
            height: 1,
          )
              : TextButton(
            onPressed: () {
              openEmailApp(context);

              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(
                    top: 40,
                    bottom:
                    MediaQuery.of(context).size.height - 400,
                    right: 40,
                    left: 40),
                duration: const Duration(minutes: 1),
                content: const Text("Please Relogin to continue"),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text("verify now!"),
          ),


          InkWell(
              onTap: (){

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (Buildcontext) => MyPhone()));
              },
              child: Text("Verify Mobile",style: TextStyle(fontSize: 15,color: Colors.red.shade900,),)),


        ],

      )

    );
  }


  void openEmailApp(BuildContext context) {
    try {
      AppAvailability.launchApp(
          Platform.isIOS ? "message://" : "com.google.android.gm")
          .then((_) {
        print("App Email launched!");
      }).catchError((err) {
        final snackBar = SnackBar(
          content: const Text("Error"),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(err);
      });
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text("Error"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
