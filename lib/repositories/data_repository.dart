import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestint/contracts/school_contract.dart';
import 'package:gestint/contracts/worker_contract.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/models/worker_model.dart';

class DataRepository implements WorkerContract, SchoolContract {

  final workerCollection = FirebaseFirestore.instance.collection("Worker");
  final schoolCollection = FirebaseFirestore.instance.collection("School");

  @override
  Future<Worker> getWorker(String id) async {
    var workers = <Worker>[];
    await workerCollection.limit(1).get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (worker) {
              workers.add(Worker.fromSnapshot(worker.data()));
            },
          ),
    );
    return workers.first;
  }

  // This function gets all schools location and other info to show on the map
  @override
  Future<List<School>> getSchools() async {
    var schools = <School>[];
    await schoolCollection.get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (school) {
              schools.add(School.fromSnapshot(school.data()));
            },
          ),
    );
    return schools;
  }

}