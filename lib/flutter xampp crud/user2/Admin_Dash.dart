import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xampp_crud/flutter%20xampp%20crud/_main_Crud_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../user1/Display_Data.dart';
import '../user1/Display_Data_with_image.dart';
import '../user1/Display_Data_with_uid.dart';
import '../user1/Send_Data_with_image.dart';
import '../user1/data_send_screen.dart';
import '../user1/data_send_with_uid_screen.dart';

class Admin_Dash extends StatefulWidget {
  const Admin_Dash({Key? key}) : super(key: key);

  @override
  _Admin_DashState createState() => _Admin_DashState();
}

class _Admin_DashState extends State<Admin_Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              IconButton(
                  onPressed: () async {
                    final SharedPreferences sharedpreferences =
                        await SharedPreferences.getInstance();
                    sharedpreferences.remove('admin_id');
                    //  Get.to(Main_screen());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => main_Crud_home()));
                  },
                  icon: Icon(Icons.exit_to_app)),
              Text("Logout")
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
        toolbarHeight: 150,
        elevation: 0,
        backgroundColor: Colors.brown.shade200,
        //  backgroundColor:  Color(0xF5951B),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Text(
          //   "Admin",
          //   style: GoogleFonts.hind(fontWeight: FontWeight.bold, fontSize: 30),
          // ),
          admin_id == null
              ? SizedBox(
                  height: 1,
                )
              : Text('${admin_id}', style: GoogleFonts.hind(fontSize: 15)),
          // email_text_admin == null
          //     ? SizedBox(
          //         height: 1,
          //       )
          //     : Text('${email_text_admin}',
          //         style: GoogleFonts.hind(fontSize: 15)),
        ]),
      ),
      //drawer: Drawer(child: AdminDrawer()),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Send Data"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>data_send_screen()));
                      },
                      icon: Icon(Icons.arrow_right_alt)),
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Display Data"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Display_Data()));
                      },
                      icon: Icon(Icons.wallet_membership_outlined)),
                ],
              ),

              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Send data with image"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Send_data_With_Image()));
                      },
                      icon: Icon(Icons.send)),
                ],
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Display data with image"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Display_Data_with_image()));
                      },
                      icon: Icon(Icons.send)),
                ],
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Data send with uid"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>data_send_with_uid_screen()));
                      },
                      icon: Icon(Icons.send)),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Display data with uid"),
                  IconButton(
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Display_Data_with_userid()));
                      },
                      icon: Icon(Icons.send)),
                ],
              ),
            ]),
      ),
    );
  }
}
