import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter xampp crud/splashscreen.dart';
import 'google_map.dart';



class firstscreen extends StatefulWidget {
  const firstscreen({Key? key}) : super(key: key);

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:AppBar(
    title:Text("welcome"),
     backgroundColor: Colors.red,
     centerTitle: true,
     leading: Icon(Icons.menu),
     actions: [
       Icon(Icons.exit_to_app),
       Icon(Icons.home)
     ],),
         body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [

              ElevatedButton(
                onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Splashscreen()));
                },
                child: Text("Crud"),
              ),
            ElevatedButton(
            onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>googlemap()));
         },
           child: Text("map check"),
            ),



            ],
            ),),
       //
    ),

    );
  }
}
