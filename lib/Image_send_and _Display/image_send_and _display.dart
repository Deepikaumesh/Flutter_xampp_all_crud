import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class image_send_and_display extends StatefulWidget {
  const image_send_and_display({Key? key}) : super(key: key);

  @override
  _image_send_and_displayState createState() => _image_send_and_displayState();
}

class _image_send_and_displayState extends State<image_send_and_display> {
  String imageName = '';
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  var descriptioncontroller = new TextEditingController();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Image";
  bool isLoading =false;

  @override
  void initState() {
    // TODO: implement initState
    descriptioncontroller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ? Center(child: CircularProgressIndicator()):

          Column(
            children: [
              imageName == '' ? Container() : Text("${imageName}"),
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
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Description", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    //upload function
                    setState(() {
                      _uploadImage();
                    });
                  },
                  child: Text("Upload")),
            ],
          ),
        ),
      ),
    );
  }

  _uploadImage() async {
    setState(() {
      isLoading =true;

    });
    var uniquekey = firestoreRef.collection(collectionName);
    String uploadfilename =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference = storageRef.ref().child(collectionName);
    UploadTask uploadtask = reference.putFile(File(imagePath!.path));
    uploadtask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    await uploadtask.whenComplete(() async {
      var uploadpath = await uploadtask.snapshot.ref.getDownloadURL();

      //now here will insert record inside database url
      if (uploadpath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniquekey.id).set({
          "description": descriptioncontroller.text,
          "image": uploadpath
        }).then((value) => showMessage("Record inserted"));
      } else {
        showMessage("Something while upading image");
      }
      setState(() {
        isLoading =false;
      });
    });
  }

  showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();

        descriptioncontroller.text = 'hello';
      });
    }
  }
}
