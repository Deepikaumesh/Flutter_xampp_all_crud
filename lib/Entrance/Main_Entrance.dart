import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Firebase_File_Display/Firebase_File_display.dart';
import '../Firebase_File_upload/Firebase_file_upload_main_Page.dart';
import '../Firebase_image/login_page.dart';
import '../Flutter_UI_Project students Fb/Crud_Operation.dart';
import '../Flutter_UI_Project students php/Splash_Screen.dart';
import '../Image_send_and _Display/image_send_and _display.dart';
import '../face_detection/page/home_page.dart';
import '../firebase_image_upload_pranathi/image_form.dart';
import '../flutter firebase Authentication/SignIn_Page.dart';
import '../flutter firebase crud/Firebase_crud.dart';
import '../flutter xampp crud/user1/splashscreen.dart';

class Main_Entrance extends StatefulWidget {
  const Main_Entrance({Key? key}) : super(key: key);

  @override
  _Main_EntranceState createState() => _Main_EntranceState();
}

class _Main_EntranceState extends State<Main_Entrance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => face_detection_HomePage()));
                  },
                  child: Text("Face Detection")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => file_crud()));
                  },
                  child: Text("Firebase file dsply")),
            ],
          ),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Firebase_file_upload_Mainpage()));
                  },
                  child: Text("Fb file upload")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Fb_image_LoginPage()));
                  },
                  child: Text("Firebase image")),
            ],
          ),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => image_form()));
                  },
                  child: Text("Fb img dta crd prnthi")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sign_In_page()));
                  },
                  child: Text("Firebase Auth")),
            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => firebase_crud()));
                  },
                  child: Text("Fb simple crud")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Splashscreen()));
                  },
                  child: Text("flutter xampp crud")),
            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Splash_Screen()));
                  },
                  child: Text("Flutter UI project for stdnts php")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => image_send_and_display()));
                  },
                  child: Text("fb img crud my")),
            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Crud_Operation()));
                  },
                  child: Text("Flutter UI project for stdnts fb")),
              ElevatedButton(
                  onPressed: () {
                 //   Navigator.push(context, MaterialPageRoute(builder: (context) => image_send_and_display()));
                  },
                  child: Text("")),
            ],
          ),
        ],
      ),
    );
  }
}
