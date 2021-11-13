import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestint/contracts/worker_contract.dart';
import 'package:gestint/models/worker_model.dart';

class DataRepository implements WorkerContract {

  final workerCollection = FirebaseFirestore.instance.collection("Worker");

  @override
  Stream<List<Worker>> getWorker(String id){

    return workerCollection
        .where("id", isEqualTo: id)
        .snapshots().map((snapshot) => snapshot.docs.map((doc) => Worker.fromSnapshot(doc.data())).toList());
  }
}