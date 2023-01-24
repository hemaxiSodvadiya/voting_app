import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_revision_22_1_23/helper/firebase_students.dart';
import 'package:firebase_revision_22_1_23/views/record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../model/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController nameController = TextEditingController();
  static TextEditingController ageController = TextEditingController();
  static TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voting App"),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Record()));
              },
              icon: Icon(
                Icons.remove_red_eye_sharp,
                color: Colors.green,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CloudFirestoreHelper.cloudFirestoreHelper.selectRecord(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(" something error cheak please...${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? data = snapshot.data;

            List<QueryDocumentSnapshot> documents = data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, i) {
                return Card(
                  color: Colors.black,
                  child: ListTile(
                    leading: Text("${i + 1}"),
                    title: Text(
                      "${documents[i]['name']}",
                      style: TextStyle(color: Colors.yellow, fontSize: 20),
                    ),
                    // subtitle: Text(
                    //     "${documents[i]['city']} & ${documents[i]['age']}"),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () async {
                    //         updateData(id: documents[i].id);
                    //       },
                    //       icon: Icon(
                    //         Icons.edit,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //     IconButton(
                    //       onPressed: () async {
                    //         await CloudFirestoreHelper.cloudFirestoreHelper
                    //             .deleteRecord(id: documents[i].id);
                    //       },
                    //       icon: Icon(
                    //         Icons.delete,
                    //         color: Colors.red,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Get.snackbar(
                              "Your Vote successfully Saved",
                              "",
                              backgroundColor: Colors.green,
                              showProgressIndicator: true,
                              icon: const Icon(
                                Icons.how_to_vote,
                                size: 30,
                              ),
                              snackStyle: SnackStyle.FLOATING,
                              colorText: Colors.blue,
                              dismissDirection: DismissDirection.horizontal,
                              forwardAnimationCurve: Curves.easeInOutBack,
                              leftBarIndicatorColor: Colors.green,
                              progressIndicatorBackgroundColor: Colors.green,
                              shouldIconPulse: true,
                              mainButton: TextButton(
                                  onPressed: () {},
                                  child: const Text("Dismiss")),
                            );

                            Map<String, dynamic> cartData = {
                              'name': documents[i]['name'],
                              'age': documents[i]['age'],
                              'city': documents[i]['city'],
                            };
                            await CloudFirestoreHelper.cloudFirestoreHelper
                                .insertRecord(data: cartData);
                            print("**********************");
                            print("**********************");
                            print("end ${documents[i]['age']}");
                            print("**********************");
                            print("**********************");
                          },
                          icon: const Icon(
                            Icons.how_to_vote_outlined,
                            color: Colors.amber,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () async {
                        //     print("**********************");
                        //     print("**********************");
                        //     print("start");
                        //     print("**********************");
                        //     print("**********************");
                        //     // updateData(id: documents[i].id);
                        //     Map<String, dynamic> update = {
                        //       'name': documents[i]['name'],
                        //       'age': documents[i]['age'],
                        //       'city': documents[i]['city'],
                        //     };
                        //     await CloudFirestoreHelper.cloudFirestoreHelper
                        //         .insertRecord(data: update);
                        //     print("**********************");
                        //     print("**********************");
                        //     print("end ${documents[i]['age']}");
                        //     print("**********************");
                        //     print("**********************");
                        //   },
                        //   icon: Icon(
                        //     Icons.how_to_vote_sharp,
                        //     color: Colors.green,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text("not possiable..."),
          );
        },
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => Record()));
      //       },
      //       child: Text("Record"),
      //     ),
      //     FloatingActionButton.extended(
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => EditNote()));
      //       },
      //       label: Text("Add Note"),
      //       icon: Icon(Icons.add),
      //     ),
      //   ],
      // ),
    );
  }

  updateData({required String id}) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    onSaved: (val) {
                      Global.name = val!;
                    },
                    validator: (val) {
                      (val!.isEmpty) ? "Enter your name first" : null;
                    },
                    decoration: InputDecoration(
                      helperText: "Name",
                    ),
                  ),
                  TextFormField(
                    controller: ageController,
                    onSaved: (val) {
                      Global.age = int.parse(val!);
                    },
                    validator: (val) {
                      (val!.isEmpty) ? "Enter your age first" : null;
                    },
                    decoration: InputDecoration(
                      helperText: "Age",
                    ),
                  ),
                  TextFormField(
                    controller: cityController,
                    onSaved: (val) {
                      Global.city = val!;
                    },
                    validator: (val) {
                      (val!.isEmpty) ? "Enter your city first" : null;
                    },
                    decoration: InputDecoration(
                      helperText: "City",
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            Map<String, dynamic> update = {
                              'name': Global.name,
                              'age': Global.age,
                              'city': Global.city,
                            };
                            CloudFirestoreHelper.cloudFirestoreHelper
                                .updateRecord(
                              id: id,
                              updateData: update,
                            );
                            nameController.clear();
                            ageController.clear();
                            cityController.clear();
                            setState(() {
                              Global.name = "";
                              Global.age = 0;
                              Global.city = "";
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("ok"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          nameController.clear();
                          ageController.clear();
                          cityController.clear();
                          setState(() {
                            Global.name = "";
                            Global.age = 0;
                            Global.city = "";
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
//
//   // updateData({required String id}) async {
//   //   return showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         content: Form(
//   //           key: formKey,
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               const Center(
//   //                 child: Text("Update"),
//   //               ),
//   //               TextFormField(
//   //                 controller: titleController,
//   //                 onSaved: (val) {
//   //                   Global.name = val!;
//   //                 },
//   //                 validator: (val) {
//   //                   (val!.isEmpty) ? 'Enter your title first...' : null;
//   //                 },
//   //                 decoration: const InputDecoration(
//   //                   hintText: "Title",
//   //                   label: Text("Enter Your title"),
//   //                 ),
//   //               ),
//   //               TextFormField(
//   //                 controller: contextController,
//   //                 onSaved: (val) {
//   //                   Global. = val!;
//   //                 },
//   //                 validator: (val) {
//   //                   (val!.isEmpty) ? 'Enter your context first' : null;
//   //                 },
//   //                 decoration: const InputDecoration(
//   //                   hintText: "Context",
//   //                   label: Text("Enter Your context"),
//   //                 ),
//   //               ),
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                 children: [
//   //                   ElevatedButton(
//   //                     onPressed: () async {
//   //                       Navigator.of(context).pop();
//   //                       if (formKey.currentState!.validate()) {
//   //                         formKey.currentState!.save();
//   //
//   //                         Map<String, dynamic> update = {
//   //                           'note_title': Global.title,
//   //                           'note_context': Global.context,
//   //                         };
//   //
//   //                         CloudFirestoreHelper.cloudFirestoreHelper
//   //                             .updateRecord(id: id, updateData: update);
//   //
//   //                         titleController.clear();
//   //                         contextController.clear();
//   //
//   //                         setState(() {
//   //                           Global.title = "";
//   //                           Global.context = "";
//   //                         });
//   //                       } else {
//   //                         Navigator.of(context).pop();
//   //                       }
//   //                     },
//   //                     child: const Text("Update"),
//   //                   ),
//   //                   OutlinedButton(
//   //                     onPressed: () {
//   //                       titleController.clear();
//   //                       contextController.clear();
//   //
//   //                       setState(() {
//   //                         Global.title = "";
//   //                         Global.context = "";
//   //                       });
//   //                       Navigator.of(context).pop();
//   //                     },
//   //                     child: const Text("Cancel"),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }
