import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreHelper {
  CloudFirestoreHelper._();

  static final CloudFirestoreHelper cloudFirestoreHelper =
      CloudFirestoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference studentsRef;
  late CollectionReference counterRef;

  void connectWithStudentsCollection() {
    studentsRef = firebaseFirestore.collection("students");
  }

  void connectionWithCounterCollection() {
    counterRef = firebaseFirestore.collection("counters");
  }

  // Future<void> insertRecord() async {
  //   connectWithStudentsCollection();
  //
  //   Map<String, dynamic> data = {
  //     'name': 'divya',
  //     'age': 32,
  //     'city': 'ahemdabad',
  //   };
  //
  //   await studentsRef.doc('3').set(data);
  // }
  //
  // Stream<QuerySnapshot> selectRecords() {
  //   connectWithStudentsCollection();
  //   return studentsRef.snapshots();
  // }

  Future<void> insertRecord({required Map<String, dynamic> data}) async {
    connectWithStudentsCollection();
    connectionWithCounterCollection();

    DocumentSnapshot documentSnapshot = await counterRef.doc('count').get();

    // Map<String, dynamic> counterData =
    //     documentSnapshot.data() as Map<String, dynamic>;
    //
    // int counter = counterData['count'];
    //
    // await studentsRef.doc('${++counter}').set(data);
    //
    // await counterRef.doc('count').update({'count': counter});
    studentsRef.add(data);
  }

  Stream<QuerySnapshot<Object?>> selectRecord() {
    connectWithStudentsCollection();

    return studentsRef.snapshots();
  }

  Future<void> updateRecord(
      {required String id, required Map<String, dynamic> updateData}) async {
    connectWithStudentsCollection();

    await studentsRef.doc(id).update(updateData);
  }

  deleteRecord({required String id}) async {
    connectWithStudentsCollection();

    await studentsRef.doc(id).delete();
  }
}
