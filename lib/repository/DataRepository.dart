import 'package:breaktimer/breaks/fajosBreak.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  // 1
  final CollectionReference collection = Firestore.instance.collection('FajosBreaks');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  // 3
  Future<DocumentReference> addBreak(FajosBreak fajosBreak) {
    return collection.add(fajosBreak.toJson());
  }
  // 4
  updateFajosBreak(FajosBreak fajosBreak) async {
    await collection.document(fajosBreak.reference.documentID).updateData(fajosBreak.toJson());
  }
}