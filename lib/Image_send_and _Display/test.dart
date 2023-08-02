import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class test extends StatefulWidget {

var id;
  var description;
  var image;

  test({required this.description,required this.image,required this.id});


  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  final CollectionReference _reference =
  FirebaseFirestore.instance.collection("Image");
  String collectionName = "Image";
  //FilePickerResult? result;
  var result;
  var img;
  var docId;
  String? filename = '';
  PlatformFile? pickedfile;
  bool isLoading = false;

  //late File fileTodisplay = File('assets/assets/baby-girl.png');
  //File? fileTodisplay;
  var fileTodisplay;
  UploadTask? uploadTask;

  //var urlDownload;

  String imageName = '';
  XFile? imagePath;
  var img_url;

  // final ImagePicker _picker = ImagePicker();
  var descriptioncontroller = new TextEditingController();
  var imag_name = new TextEditingController();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;


  var _descriptioncontroller = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _descriptioncontroller =TextEditingController(text: widget.description);
    docId=widget.id;
    img=widget.image;
    super.initState();
  }

  imagePicker() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        filename = result!.files.first.name;
        pickedfile = result!.files.first;
        fileTodisplay = File(pickedfile!.path.toString());
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 160, vertical: 360),
            child: CircularProgressIndicator(),
          )
              : Column(
            children: [
              fileTodisplay == null
                //  ? Image.network(widget.image,scale: 200,)
              ?Container(
          height: 300,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade200,
                image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover)),
          )
                  : Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade200,
                    image: DecorationImage(
                        image: FileImage(fileTodisplay),
                        fit: BoxFit.cover)),
              ),

              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      imagePicker();
                    });
                  },
                  child: Text("Select image")),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptioncontroller,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    //upload function
                    setState(() {
                      update_img();
                    });
                  },
                  child: Text("Update")),
              Text(widget.id),

            ],
          ),
        ),
      ),
    );

  }


  Future<void> update_img()  async {

    pickedfile = result!.files.first;
    fileTodisplay = File(pickedfile!.path.toString());
    if (result != null) {
     // String fileName = result.path.split('/').last;
      filename = result!.files.first.name;
      var snapshot = await FirebaseStorage.instance.ref()
          .child('Image/$filename')
          .putFile(result);
      var url = await snapshot.ref.getDownloadURL();

      img_url = url.toString();
    }
    else {
      img_url =img;
    }
    Map<String, dynamic> demodata = {
      "image": img_url,
      "description": _descriptioncontroller.text,
    };
    CollectionReference collectionreference =
    FirebaseFirestore.instance.collection('Image');
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


//  // var ids = _reference.id;