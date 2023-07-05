import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xampp_crud/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'Edit_Data_with_img.dart';




class Datamodels {
  final String id;
  final String name;
  final String price;
  final String image;

  Datamodels({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}


class Display_Data_with_image extends StatefulWidget {
  const Display_Data_with_image({Key? key}) : super(key: key);

  @override
  _Display_Data_with_imageState createState() => _Display_Data_with_imageState();
}

class _Display_Data_with_imageState extends State<Display_Data_with_image> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink.shade300,
        title: Text("Display Data"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder(
              future: getRequest(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null || snapshot.data == false) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red.shade900,
                            strokeWidth: 5,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Loading...",
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Flexible(
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, index) {
                                return SingleChildScrollView(
                                 // scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        child: Card(


                                          color: Colors.cyan.shade50,
                                          //shadowColor: Colors.red,
                                          elevation: 8,
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),

                                          child: Container(
                                            // color: Colors.red,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height /
                                                8.5,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                1.1,
                                            //padding: EdgeInsets.fromLTRB(10, 15, 50, 15),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.all(15.0),
                                              leading: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(color: Colors.red.shade900),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot.data[index].image),
                                                  ),
                                                ),
                                              ),
                                              onTap: ()
                                              {
                                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_Data_with_image(data_user: snapshot.data[index],)));
                                              },
                                              title: Text("name:"+snapshot.data[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                GoogleFonts.lora(fontSize: 15, color: Colors.pink.shade700),
                                              ),
                                              subtitle: Row(
                                                children:[
                                                  Text(" price:"+
                                                      snapshot.data[index].price,
                                                    overflow: TextOverflow.ellipsis,
                                                    style:
                                                    GoogleFonts.lora(fontSize: 15, color: Colors.pink.shade700),
                                                  ),

                                                  SizedBox(width: 10,),

                                                  IconButton(onPressed: (){
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Edit_Data_with_image(data_user: snapshot.data[index],)));

                                                  }, icon: Icon(Icons.edit)),
                                                  IconButton(onPressed: (){
                                                    delrecord(snapshot.data[index].id);

                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Display_Data_with_image()));


                                                    Fluttertoast.showToast(
                                                        msg: 'Data Deleted ',
                                                        toastLength: Toast.LENGTH_LONG,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.blueGrey);


                                                  }, icon: Icon(Icons.delete)),



                                                ],  ),


                                            ),

                                          ),
                                        ),

                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),

    );
  }

  Future<List<Datamodels>> getRequest() async {
    //replace your restFull API here.

    final response = await http.get(Uri.parse(
        "http://$ip_address/internship_crud/display_data_with_image.php"
    ));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Datamodels> users = [];
    for (var singleUser in responseData) {
      Datamodels user = Datamodels(
        // productqty: singleUser["productqty"].toString(),

        name: singleUser["name"].toString(),
        id: singleUser["id"].toString(),
        price:singleUser["price"].toString(),
        image: singleUser["image"].toString(),
      );

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }



  Future<void> delrecord(String id) async {
    String url =
        "http://$ip_address/internship_crud/delete_data_with_image.php";
    var res = await http.post(Uri.parse(url), body: {
      "id": id,
    });
    var resoponse = jsonDecode(res.body);
    if (resoponse["success"] == "true") {
      print("success");
    }
  }
}
