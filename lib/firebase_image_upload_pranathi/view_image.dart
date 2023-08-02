import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_image.dart';

class view_image extends StatefulWidget {
  const view_image({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _view_imageState();
  }
}

class _view_imageState extends State<view_image> {

  // final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade500,
        title: Text("Image View"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('image_tb').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              // print(document.id);

               var id=document.id;

              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  child: Card(


                    color: Colors.indigo.shade50,

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
                            border: Border.all(color: Colors.indigo.shade900),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(document['image']),
                            ),
                          ),
                        ),
                        // onTap: ()
                        // {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>edit_img(data_user: snapshot.data[index],)));
                        // },
                        title: Text("Name  : "+document['name'],
                          overflow: TextOverflow.ellipsis,
                          style:
                          GoogleFonts.lora(fontSize: 15, color: Colors.indigo.shade900),
                        ),
                        trailing: Wrap(
                          spacing:-1, // space between two icons
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.edit,color: Colors.indigo,),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    edit_image(name:document['name'],image :document['image'],id: document.id,
                                )));
                              },
                            ),// icon-1
                            IconButton(
                              icon: const Icon(Icons.delete,color: Colors.indigo),
                              onPressed: () {
                                delete(document.id);
                              },
                            ),
                          ],
                        ),


                      ),

                    ),
                  ),
                ),
              );

            }).toList(),
          );
        },
      ),
    );
  }

  void delete(String id) {

    CollectionReference collectionreference =
    FirebaseFirestore.instance.collection('image_tb');
    collectionreference.doc(id).delete()
    .whenComplete(() {
      Fluttertoast.showToast(
        msg: "Data Deleted Successfully..",
      );
    }
    );

  }



}
