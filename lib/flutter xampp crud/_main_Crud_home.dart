import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xampp_crud/flutter%20xampp%20crud/user1/homepage.dart';
import 'package:flutter_xampp_crud/flutter%20xampp%20crud/user2/Admin_splashscreen.dart';





class main_Crud_home extends StatefulWidget {
  const main_Crud_home({Key? key}) : super(key: key);

  @override
  State<main_Crud_home> createState() => _main_Crud_homeState();
}

class _main_Crud_homeState extends State<main_Crud_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Crud main home"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page()));
                },
                child: Text("User 1"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Splashscreen()));
                },
                child: Text("User 2"),
              ),



            ],
          ),),
        //
      ),

    );
  }
}
