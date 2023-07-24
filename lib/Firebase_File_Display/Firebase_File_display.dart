import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class file_crud extends StatefulWidget {
  const file_crud({Key? key}) : super(key: key);

  @override
  _file_crudState createState() => _file_crudState();
}

class _file_crudState extends State<file_crud> {

    final CollectionReference _reference = FirebaseFirestore.instance.collection(
      "data_image");
     FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController name = TextEditingController();
  TextEditingController place = TextEditingController();
    TextEditingController image = TextEditingController();



  FilePickerResult? result;
  String? filename;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileTodisplay;
  UploadTask? uploadTask;
    var urlDownload;


    void pickFile() async {
      try {
        setState(() {
          isLoading = true;
        });

        result = await FilePicker.platform.pickFiles(
          type: FileType.any,
          allowMultiple: false,
        );
        if (result != null) {
          filename = result!.files.first.name;
          pickedfile = result!.files.first;
          fileTodisplay = File(pickedfile!.path.toString());
image.text =uploadTask.toString();
          print('File name $filename');
        }

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    }

    Future uploadFile() async {
      final path = 'files_demo2/${pickedfile!.name}';
      // final file = File(pickedfile!.path.toString());
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(fileTodisplay!);

      final snapshot = await uploadTask!.whenComplete((){});

      urlDownload = await snapshot.ref.getDownloadURL();
      print("Download Link $urlDownload");

    }

    Future<void> _upload2(String inputSource) async {
      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(filename).putFile(fileTodisplay!,
            SettableMetadata(customMetadata: {
              'name': name.text,
              'place': place.text,
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }


    Future<void> Create([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        name.text = documentSnapshot['name'];
        place.text = documentSnapshot['place'].toString();
        //fileTodisplay =documentSnapshot['url'].toString() as File?;
        image.text =documentSnapshot['image'].toString() ;

      }

      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(labelText: 'title'),
                  ),
                  TextField(
                    controller: place,
                    decoration: InputDecoration(labelText: 'description'),
                  ),
                  TextField(
                    controller: image,
                    decoration: InputDecoration(labelText: 'image address'),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        pickFile();
                      },
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery')),
                  ElevatedButton(
                      onPressed: () async {
                        await _reference
                            .add({'name': name.text, 'place': place.text,'image': uploadTask});
                        await uploadFile();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (Buildcontext) => firebase_crud()));

                        print(uploadTask);
                      },
                      child: Text("Create button")),

                  fileTodisplay == null ? Text("no image selected"):
                  Text(fileTodisplay!.toString()),
                  // SizedBox(
                  //   height: 300,
                  //   width: 400,
                  //   child: Image.file(fileTodisplay),
                  // ),
                ],
              ),
            );

          });

    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('dbestech'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Name:"),
                    Expanded(child: TextField(controller: name,
                      decoration: InputDecoration(border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),),)),


                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Text("Place:"),
                    Expanded(child: TextField(controller: place,
                      decoration: InputDecoration(border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),),)),

                  ],
                ),

                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () => _upload2('camera'),
                        icon: const Icon(Icons.camera),
                        label: const Text('camera')),
                    ElevatedButton.icon(
                        onPressed: () {
                          pickFile();
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('Gallery')),
                    ElevatedButton.icon(
                      onPressed: ()=>Create(),
                        // onPressed: () => _upload2('Gallery'),
                        icon: const Icon(Icons.library_add),
                        label: const Text('upload')),
                  ],

                ),

              ],
            ),
          ),
        );
  }
}
