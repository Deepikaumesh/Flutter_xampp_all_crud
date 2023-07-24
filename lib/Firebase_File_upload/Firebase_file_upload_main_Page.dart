import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Firebase_file_upload_Mainpage extends StatefulWidget {
  const Firebase_file_upload_Mainpage({Key? key}) : super(key: key);

  @override
  _Firebase_file_upload_MainpageState createState() =>
      _Firebase_file_upload_MainpageState();
}

class _Firebase_file_upload_MainpageState extends State<Firebase_file_upload_Mainpage> {
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
       //  final path = 'files/${pickedfile!.name}';
       // // final file = File(pickedfile!.path.toString());
       //  final ref = FirebaseStorage.instance.ref().child(path);
       //  uploadTask = ref.putFile(fileTodisplay!);
       //
       //  final snapshot = await uploadTask!.whenComplete((){});
       //
       //  final urlDownload = await snapshot.ref.getDownloadURL();
       //  print("Download Link $urlDownload");

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
  final path = 'files/${pickedfile!.name}';
  // final file = File(pickedfile!.path.toString());
  final ref = FirebaseStorage.instance.ref().child(path);
  uploadTask = ref.putFile(fileTodisplay!);

  final snapshot = await uploadTask!.whenComplete((){});

   urlDownload = await snapshot.ref.getDownloadURL();
  print("Download Link $urlDownload");

}
  // FilePickerResult? result;
  // PlatformFile? pickedFile1;
  // String? filename1;
  // File? fileTodisplay1;
  // bool isLoading1 = false;

  // Future selectFile() async {
  //   try{
  //     setState(() {
  //       isLoading1 = true;
  //     });
  //   result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;
  //   setState(() {
  //     if (result != null) {
  //       filename1 = result!.files.first.name;
  //       pickedfile = result!.files.first;
  //       fileTodisplay1 = File(pickedfile!.path.toString());
  //
  //       print('File name $filename1');
  //     }
  //   });}







    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.any,
    //   allowedExtensions: ['jpg', 'png'],
    //   );
    // if(result == null) return;
    //
    // setState(() {
    //     pickedFile =result.files.first;
    //     fileTodisplay1 =File(pickedfile!.path.toString());
    //   });






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // if (pickedFile1 != null)
            //   Expanded(
            //       child: Container(
            //           color: Colors.blue[100],
            //           // child: Image.file(File(pickedFile!.path),width: double.infinity,fit: BoxFit.cover,),
            //           child: SizedBox(
            //             height: 300,
            //             width: 400,
            //             child: Image.file(fileTodisplay1!),
            //           )
            //           // child: Center(
            //           //   child: Text(pickedFile!.name),
            //           // ),
            //           )),
            SizedBox(
              height: 32,
            ),
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                  onPressed: () {
                    pickFile();
                  },
                  child: Text("Pick a file")),
            ),
            if (pickedfile != null)

            SizedBox(
              height: 300,
              width: 400,
              child: Text(fileTodisplay!.toString()),
            ),

              // SizedBox(
              //   height: 300,
              //   width: 400,
              //   child: Image.file(fileTodisplay!),
              // ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //    //   selectFile();
            //
            //     },
            //     child: Text("select file"),
            //   ),
            // ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  uploadFile();
                },
                child: Text("Upload file file"),
              ),
            ),

            Center(
              child:Text("Download Link${urlDownload.toString()}"),
              ),


            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        pickFile();
                      },
                      child: Text("pickfile")),
            ),
            if (pickedfile != null)
              SizedBox(
                height: 300,
                width: 400,
                child: Image.file(fileTodisplay!),
              )
          ],
        ),
      ),
    );
  }
}
