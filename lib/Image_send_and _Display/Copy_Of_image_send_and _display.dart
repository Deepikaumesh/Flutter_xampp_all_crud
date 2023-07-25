// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class image_send_and_display extends StatefulWidget {
//   const image_send_and_display({Key? key}) : super(key: key);
//
//   @override
//   _image_send_and_displayState createState() => _image_send_and_displayState();
// }
//
// class _image_send_and_displayState extends State<image_send_and_display> {
//
//   final CollectionReference _reference = FirebaseFirestore.instance.collection("Image");
//   FilePickerResult? result;
//   String? filename;
//   PlatformFile? pickedfile;
//   bool isLoading = false;
//   File? fileTodisplay;
//   UploadTask? uploadTask;
//   var urlDownload;
//
//   String imageName = '';
//   XFile? imagePath;
//   final ImagePicker _picker = ImagePicker();
//   var descriptioncontroller = new TextEditingController();
//   FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
//   FirebaseStorage storageRef = FirebaseStorage.instance;
//   String collectionName = "Image";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     descriptioncontroller = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: isLoading ? Center(child: CircularProgressIndicator()):
//
//           Column(
//             children: [
//               imageName == '' ? Container() : Text("${imageName}"),
//               SizedBox(
//                 height: 10,
//               ),
//               OutlinedButton(
//                   onPressed: () {
//                     setState(() {
//                       imagePicker();
//                     });
//                   },
//                   child: Text("Select image")),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: descriptioncontroller,
//                 minLines: 3,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                     labelText: "Description", border: OutlineInputBorder()),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     //upload function
//                     setState(() {
//                       _uploadImage();
//                     });
//                   },
//                   child: Text("Upload")),
//               // Expanded(
//               //   child: FutureBuilder<QuerySnapshot>(
//               //       future: firestoreRef.collection(collectionName).get(),
//               //       builder: (context,snapshot){
//               //         if(snapshot.connectionState ==ConnectionState.waiting ){
//               //           return Center(
//               //             child:CircularProgressIndicator(),
//               //           );
//               //         }
//               //         else if(snapshot.hasData){
//               //           return ListView.builder(
//               //               itemCount: 2,
//               //               itemBuilder: (context,index){
//               //                 return  Card(
//               //                   child: Column(
//               //                     children: [
//               //                       Image.network("",
//               //                         height: 100,
//               //                         width: 100,
//               //                         fit: BoxFit.fill,),
//               //                       SizedBox(width: 10,),
//               //                       Text(""),
//               //
//               //                     ],
//               //                   ),
//               //                 );
//               //
//               //               });
//               //
//               //         }
//               //
//               //   }),
//               // ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future uploadFile() async {
//   //   PlatformFile? pickedfile = imagePath?.files.first;
//   //   final path = 'files/${pickedfile!.name}';
//   //   // final file = File(pickedfile!.path.toString());
//   //   final ref = FirebaseStorage.instance.ref().child(path);
//   //   File fileTodisplay = File(pickedfile!.path.toString());
//   //   UploadTask uploadTask = ref.putFile(fileTodisplay!);
//   //
//   //   final snapshot = await uploadTask!.whenComplete((){});
//   //
//   //   urlDownload = await snapshot.ref.getDownloadURL();
//   //   print("Download Link $urlDownload");
//   //
//   // }
//
//   // _uploadImage() async {
//   //   setState(() {
//   //     isLoading =true;
//   //
//   //   });
//   //   var uniquekey = firestoreRef.collection(collectionName).doc();
//   //   String uploadfilename = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
//   //   Reference reference = storageRef.ref().child(collectionName);
//   //   UploadTask uploadtask = reference.putFile(File(imagePath!.path));
//   //   uploadtask.snapshotEvents.listen((event) {
//   //     print(event.bytesTransferred.toString() +
//   //         "\t" +
//   //         event.totalBytes.toString());
//   //   });
//   //
//   //   await uploadtask.whenComplete(() async {
//   //     var uploadpath = await uploadtask.snapshot.ref.getDownloadURL();
//   //
//   //     //now here will insert record inside database url
//   //     if (uploadpath.isNotEmpty) {
//   //       firestoreRef.collection(collectionName).doc(uniquekey.id).set({
//   //         "description": descriptioncontroller.text.toString(),
//   //         "image": uploadpath,
//   //       }).then((value) => showMessage("Record inserted"));
//   //     } else {
//   //       showMessage("Something while upading image");
//   //     }
//   //     setState(() {
//   //       isLoading =false;
//   //       descriptioncontroller.clear();
//   //       // descriptioncontroller.text ="" ;
//   //       imageName = "";
//   //     });
//   //   });
//   // }
//   _uploadImage() async {
//     setState(() {
//       isLoading =true;
//
//     });
//     var uniquekey = firestoreRef.collection(collectionName).doc();
//     final path = 'files2/${pickedfile!.name}';
//     String uploadfilename = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
//     Reference reference =  FirebaseStorage.instance.ref().child(path);
//     UploadTask uploadtask = reference.putFile(fileTodisplay!);
//     uploadtask.snapshotEvents.listen((event) {
//       print(event.bytesTransferred.toString() +
//           "\t" +
//           event.totalBytes.toString());
//     });
//
//     await uploadtask.whenComplete(() async {
//       var uploadpath = await uploadtask.snapshot.ref.getDownloadURL();
//
//       //now here will insert record inside database url
//       if (uploadpath.isNotEmpty) {
//         firestoreRef.collection(collectionName).doc(uniquekey.id).set({
//           "description": descriptioncontroller.text.toString(),
//           "image": uploadpath,
//         }).then((value) => showMessage("Record inserted"));
//       } else {
//         showMessage("Something while upading image");
//       }
//       setState(() {
//         isLoading =false;
//         descriptioncontroller.clear();
//         // descriptioncontroller.text ="" ;
//         imageName = "";
//       });
//     });
//   }
//
//   showMessage(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(msg),
//       duration: const Duration(seconds: 3),
//     ));
//   }
//
//   // imagePicker() async {
//   //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//   //   if (image != null) {
//   //     setState(() {
//   //       imagePath = image;
//   //       imageName = image.name.toString();
//   //
//   //       //descriptioncontroller.text=
//   //     });
//   //   }
//   // }
//
//
//   imagePicker() async {
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false,
//     );
//     if (result != null) {
//       filename = result!.files.first.name;
//       pickedfile = result!.files.first;
//       fileTodisplay = File(pickedfile!.path.toString());
//     }
//   }
// }
