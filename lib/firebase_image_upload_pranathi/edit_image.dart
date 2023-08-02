import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xampp_crud/firebase_image_upload_pranathi/view_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';



class edit_image extends StatefulWidget {

  final  name,image,id;
  const edit_image({Key? key, required this.name, required this.image, required this.id}) : super(key: key);


  @override
  _edit_imageState createState() => _edit_imageState();
}

class _edit_imageState extends State<edit_image> {

  TextEditingController _name=TextEditingController();

  var _image;
  var docId;
  var img;
  var img_url;
  final picker = ImagePicker();



  late bool status;

  late String message;

  File? get filePath => null;


  @override
  void initState() {

    _name=TextEditingController(text: widget.name);
    docId=widget.id;
    img=widget.image;

    status = false;
    message = "";

    super.initState();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future choose_image_gallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future choose_image_camera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this._image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        title: Text('Edit Form'),
        backgroundColor: Colors.green.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height : 240,
            //
            //   child:  Image.asset('assets/images/c8.avif'),),
            Container(
              // margin: EdgeInsets.all(30),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                // border:Border.all(width:2,color: Colors.green.shade600),
                // borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              // height: MediaQuery.of(context).size.height,
              // width: double.infinity,
              child: Form(
                key: formkey,
                child: Column(

                  children: [
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: _name,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Name";
                        }
                        return null;
                      },
                      onSaved: (name) {},
                      obscureText: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.green.shade300),
                        ),
                        label: Text("Name"),
                        labelStyle: TextStyle(color: Colors.green.shade900),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            // color: Colors.grey[400],
                            color: Colors.grey.shade500,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade500,
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Image",
                          style: GoogleFonts.hindVadodara(
                            fontSize: 20,
                            color: Colors.green.shade900,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.photo_outlined,
                            size: 35,
                            color: Colors.green.shade600,
                          ),
                          onPressed: () {
                            choose_image_gallery();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                            color: Colors.green.shade600,
                          ),
                          onPressed: () {
                            choose_image_camera();
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                          height: 100,
                          width: 200,
                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),  color: Colors.grey,
                          //),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: _image != null
                                ?
                            Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )
                                :
                            Image.network(
                              widget.image,
                              fit: BoxFit.cover,
                            )
                          )),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 17,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            setState(()  {

                              update_img();

                              // uploadImage();
                              // String fileName = _image.path.split('/').last;
                              // var snapshot = await FirebaseStorage.instance.ref()
                              //     .child('images/$fileName')
                              //     .putFile(_image)
                              // .whenComplete(() {
                              //
                              //   Fluttertoast.showToast(
                              //     msg: "Image Uploaded successfully",
                              //     // // toastLength: Toast.LENGTH_SHORT,
                              //     // backgroundColor: Colors.teal,
                              //     // textColor: Colors.white
                              //   );
                              // })
                              //     .catchError((e) {
                              //
                              // });

                            });
                          }
                        },
                        child: Text(
                          'UPDATE',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),

                    ),
                    SizedBox(height: 20,),

                    // Text(widget.id),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade500,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>view_image()));

                    }, child: Text("View Images")),
                    SizedBox(height:80,)
                    // Text(
                    //   status ? message : message,
                    //   style: GoogleFonts.lato(
                    //       fontSize: 12,
                    //       color: Colors.red.shade900,
                    //       fontWeight: FontWeight.bold),
                    // ),

                  ],
                ),

                //],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> update_img()  async {
    if (_image != null) {

      String fileName = _image.path.split('/').last;

      var snapshot = await FirebaseStorage.instance.ref().child('My_images/$fileName').putFile(_image);

      var url = await snapshot.ref.getDownloadURL();

       img_url = url.toString();
    }
    else {
      img_url =img;
    }
      Map<String, dynamic> demodata = {
        "image": img_url,
        "name": _name.text,
      };
      CollectionReference collectionreference =
      FirebaseFirestore.instance.collection('image_tb');
      collectionreference.doc(docId).update(demodata)
          .whenComplete(() async {

        Fluttertoast.showToast(
          msg: "Updated successfully",
          // // toastLength: Toast.LENGTH_SHORT,
          // backgroundColor: Colors.teal,
          // textColor: Colors.white
        );
      })
          .catchError((e) {

      });
  }

}

