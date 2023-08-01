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
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("Image");
  String collectionName = "Image";
  FilePickerResult? result;
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

  // final ImagePicker _picker = ImagePicker();
  var descriptioncontroller = new TextEditingController();
  var imag_name = new TextEditingController();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    isLoading = false;
    descriptioncontroller = TextEditingController();
    imag_name = TextEditingController();
    super.initState();
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
                        ? Icon(
                            Icons.photo,
                            size: 400,
                            color: Colors.blue.shade400,
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
                    filename == ''
                        ? Text("No image selected")
                        : Text(
                            '${filename}',
                            style: TextStyle(color: Colors.red),
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
                      controller: descriptioncontroller,
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
                            _uploadImage();
                          });
                        },
                        child: Text("Upload")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Display_Data_Image()));
                        },
                        child: Text("Display Data")),
                  ],
                ),
        ),
      ),
    );
  }

  _uploadImage() async {
    setState(() {
      isLoading = true;
    });
    var uniquekey = firestoreRef.collection(collectionName).doc();
    final path = 'files2/${pickedfile!.name}';
    String uploadfilename =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadtask = reference.putFile(fileTodisplay!);
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
          "description": descriptioncontroller.text.toString(),
          "image": uploadpath,
        }).then((value) => showMessage("Record inserted"));
      } else {
        showMessage("Something while upading image");
      }
      setState(() {
        isLoading = false;
        descriptioncontroller.clear();
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
}

class Display_Data_Image extends StatefulWidget {
  const Display_Data_Image({Key? key}) : super(key: key);

  @override
  _Display_Data_ImageState createState() => _Display_Data_ImageState();
}

class _Display_Data_ImageState extends State<Display_Data_Image> {
  var descriptioncontroller = new TextEditingController();



  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("Image");

  String collectionName = "Image";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: _reference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            documentSnapshot['image'],
                          ),
                        ),
                        title: Text(documentSnapshot['description'].toString()),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                             ///      Navigator.push(context, MaterialPageRoute(builder: (context)=>Image_Data_Update_Page(description:documentSnapshot[index])));
                                   // _Update(documentSnapshot);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    Delete(documentSnapshot.id);
                                  },
                                  icon: Icon(Icons.delete)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<void> Delete(String id) async {
    await _reference.doc(id).delete();
  }
}

// class Image_Data_Update_Page extends StatefulWidget {
// var description;
// Image_Data_Update_Page({required this.description})
//
//   @override
//   _Image_Data_Update_PageState createState() => _Image_Data_Update_PageState();
// }
//
// class _Image_Data_Update_PageState extends State<Image_Data_Update_Page> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update data image"),
//       ),
//       body: Container(),
//     );
//   }
// }