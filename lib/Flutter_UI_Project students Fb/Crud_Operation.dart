import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Insert_Data.dart';

final db = FirebaseFirestore.instance;

String? value;

class Crud_Operation extends StatefulWidget {
  const Crud_Operation({Key? key}) : super(key: key);

  @override
  State<Crud_Operation> createState() => _Crud_OperationState();
}

class _Crud_OperationState extends State<Crud_Operation> {


  @override
  void initState() {
    // TODO: implement initState
    value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Insert()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: db.collection('test').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, int index) {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
              // age =documentSnapshot['name'];
              return ListTile(
                title: Text(documentSnapshot['name']),
                onTap: () {},
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    db.collection('test').doc(documentSnapshot.id).delete();
                  },
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    AlertDialog alert = AlertDialog(
                      title: Text("Update Data"),
                      content: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: documentSnapshot["name"],
                        ),
                        onChanged: (String _val) {
                          // Storing the value of the text entered in the variable value.
                          value = _val;
                        },
                      ),
                      actions: [
                        //Text(documentSnapshot["name"]),
                        OutlinedButton(
                            onPressed: () {
                              setState(() {
                                db
                                    .collection('test')
                                    .doc(documentSnapshot.id)
                                    .update({
                                  'name': value,
                                });
                              });

                              Navigator.pop(context);
                            },
                            child: Text("Update"))
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
