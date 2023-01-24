import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_revision_22_1_23/helper/firebase_students.dart';
import 'package:firebase_revision_22_1_23/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/controller.dart';
import '../model/global.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());
    int? totalProduct;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Record"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CloudFirestoreHelper.cloudFirestoreHelper.selectRecord(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SelectableText("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? data = snapshot.data;
            List<QueryDocumentSnapshot> documents = data!.docs;
            Global.addVoted =
                documents.map((e) => addVote.fromMap(dataVote: e)).toList();
            totalProduct = Global.addVoted.length;
            return Column(
              children: [
                Obx(() => Text(
                      "${productController.totalPrice}",
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    )),
              ],
            );
          }
          return Center(
            child: Text("Not Possible"),
          );
        },
      ),
    );
  }
}
