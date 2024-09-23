import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/constants/keys.dart';
import '../models/counter.dart';

Future<void> saveCounter(Counter counter) async {
  CollectionReference countersCollection = FirebaseFirestore.instance.collection(MyKeys.counters);
  await countersCollection.add(counter.toMap());
}

Future<void> deleteCounter(String counterId) async {
  CollectionReference countersCollection = FirebaseFirestore.instance.collection(MyKeys.counters);
  await countersCollection.doc(counterId).delete();
}

Stream<List<Counter>> getAllCounters() {
  CollectionReference countersCollection = FirebaseFirestore.instance.collection(MyKeys.counters);
  return countersCollection.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return Counter.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}


Future<Counter?> getCounterById(String docId) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection(MyKeys.counters).doc(docId).get();
  if (doc.exists) {
    return Counter.fromMap(doc.data() as Map<String, dynamic>);
  }
  return null;
}

Future<String> uploadImageToStorage(File image) async {
  String fileName = path.basename(image.path);
  Reference storageReference = FirebaseStorage.instance.ref().child('counter_images/$fileName');
  UploadTask uploadTask = storageReference.putFile(image);
  await uploadTask.whenComplete(() => null);
  return await storageReference.getDownloadURL();
}


