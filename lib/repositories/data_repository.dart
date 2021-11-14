import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/school_contract.dart';
import 'package:gestint/contracts/worker_contract.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/models/worker_model.dart';

class DataRepository implements WorkerContract,
    SchoolContract, PersonalDataContract {

  final workerCollection = FirebaseFirestore.instance.collection("Worker");
  final personalDataCollection = FirebaseFirestore.instance.collection("PersonalData");
  final schoolCollection = FirebaseFirestore.instance.collection("School");

  @override
  Future<Worker> getWorker(String id) async {
    var workers = <Worker>[];
    await workerCollection.limit(1)
        .where('id', isEqualTo: id)
        .get().then(
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

  @override
  Future<PersonalData> getPersonalData(String id) async {
    print('Buscando en repository');
    var personalDataArray = <PersonalData>[];
    await personalDataCollection.limit(1)
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (pd) {
                  personalDataArray.add(PersonalData.fromSnapshot(pd.data()));
            },
          ),
    );
    return personalDataArray.first;
  }

}