import 'package:flutter/material.dart';

import 'Splash_Screen.dart';



class entrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100,
                horizontal: 65
            ),
            child: Container(

              height: 200,
              width: 250,
              child: Icon(Icons.image,size: 250,color: Colors.grey.shade300),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 25),
                  child: Column(
                    children: [
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                      const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.pink.shade300,
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 15, bottom: 15),
                        ),

                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Splash_Screen()));
                        },


                        //color: Colors.indigo,
                        child: Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding:
                      const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.pink.shade300,
                          padding: EdgeInsets.only(
                              left: 40, right: 40, top: 15, bottom: 15),
                        ),
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (context) => Hope_User_Splash()));
                        },
                        child: Text(
                          'User',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


