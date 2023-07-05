import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xampp_crud/flutter%20xampp%20crud/data_send_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Display_Data.dart';
import 'Display_Data_with_image.dart';
import 'Send_Data_with_image.dart';
import 'login page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Logout"),
                IconButton(
                    onPressed: () async {
                      final SharedPreferences sharedpreferences =
                      await SharedPreferences.getInstance();
                      sharedpreferences.remove('get_id');
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>loginpage()));
                    },
                    icon: Icon(Icons.exit_to_app)),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
