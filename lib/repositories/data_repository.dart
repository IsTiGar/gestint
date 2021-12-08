import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestint/contracts/available_workers_contract.dart';
import 'package:gestint/contracts/certifications_contract.dart';
import 'package:gestint/contracts/charges_contract.dart';
import 'package:gestint/contracts/courses_contract.dart';
import 'package:gestint/contracts/courses_finished_contract.dart';
import 'package:gestint/contracts/current_job_contract.dart';
import 'package:gestint/contracts/destinations_contract.dart';
import 'package:gestint/contracts/documents_contract.dart';
import 'package:gestint/contracts/payroll_contract.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/procedure_result_contract.dart';
import 'package:gestint/contracts/procedures_contract.dart';
import 'package:gestint/contracts/scale_contract.dart';
import 'package:gestint/contracts/schools_contract.dart';
import 'package:gestint/contracts/single_procedure_contract.dart';
import 'package:gestint/contracts/user_contract.dart';
import 'package:gestint/contracts/worker_contract.dart';
import 'package:gestint/models/certification_model.dart';
import 'package:gestint/models/charge_model.dart';
import 'package:gestint/models/course_finished_model.dart';
import 'package:gestint/models/course_model.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/destination_model.dart';
import 'package:gestint/models/document_model.dart';
import 'package:gestint/models/payroll_model.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/models/procedure_result_model.dart';
import 'package:gestint/models/scale_model.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/models/worker_full_model.dart';
import 'package:gestint/models/worker_model.dart';

/// Repository that get all information from Firestore
/// Some methods write on the remote database

class DataRepository implements WorkerContract,
    SchoolsContract, PersonalDataContract, CertificationsContract,
    ChargesContract, CoursesContract, CoursesFinishedContract, 
    DestinationsContract, DocumentsContract, PayrollContract,
    ScaleContract, AvailableWorkersContract, CurrentJobContract,
    ProceduresContract, SingleProcedureContract, UserContract,
    ProcedureResultContract{

  /* Firestore collections */
  final workerCollection = FirebaseFirestore.instance.collection("Worker");
  final workerFullCollection = FirebaseFirestore.instance.collection("WorkerFull");
  final personalDataCollection = FirebaseFirestore.instance.collection("PersonalData");
  final schoolCollection = FirebaseFirestore.instance.collection("School");
  final certificationCollection = FirebaseFirestore.instance.collection("Certification");
  final chargeCollection = FirebaseFirestore.instance.collection("Charge");
  final destinationCollection = FirebaseFirestore.instance.collection("Destination");
  final documentCollection = FirebaseFirestore.instance.collection("Document");
  final payrollCollection = FirebaseFirestore.instance.collection("Payroll");
  final scaleCollection = FirebaseFirestore.instance.collection("Scale");
  final courseFinishedCollection = FirebaseFirestore.instance.collection("CourseFinished");
  final courseCollection = FirebaseFirestore.instance.collection("Course");
  final jobCollection = FirebaseFirestore.instance.collection("Job");
  final procedureCollection = FirebaseFirestore.instance.collection("Procedure");
  final userCollection = FirebaseFirestore.instance.collection("User");

  @override
  Future<Worker> getWorker(String id) async {
    List<Worker> workerList = await workerCollection.limit(1)
        .where('id', isEqualTo: id).get().then(
            (snapshot){
          return snapshot.docs.map(
                  (worker) => Worker.fromSnapshot(worker.data())).toList();
        }
    );
    return workerList.first;

  }

  @override
  Future<List<WorkerFull>> getAvailableWorkers(String body, String function) async{
    List<WorkerFull> workerFullList = await workerFullCollection
        .where('body', isEqualTo: body)
        .where('function', isEqualTo: function)
        .where('available', isEqualTo: true)
        .orderBy('score', descending: true)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (availableWorker) => WorkerFull.fromSnapshot(availableWorker.data())).toList();
        }
    );
    return workerFullList;
  }

  // This function gets all schools location and other info to show on the map
  @override
  Future<List<School>> getSchools() async {
    List<School> schoolList = await schoolCollection
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (school) => School.fromSnapshot(school.data())).toList();
        }
    );
    return schoolList;
  }

  @override
  Future<PersonalData> getPersonalData(String id) async {
    List<PersonalData> personalDataList = await personalDataCollection.limit(1)
        .where('id', isEqualTo: id).get().then(
            (snapshot){
          return snapshot.docs.map(
                  (pd) => PersonalData.fromSnapshot(pd.data())).toList();
        }
    );

    return personalDataList.first;
  }

  @override
  Future<List<Certification>> getCertifications(String id) async {
    List<Certification> certificationList = await certificationCollection
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (certification) => Certification.fromSnapshot(certification.data())).toList();
        }
    );
    return certificationList;
  }

  @override
  Future<List<Charge>> getCharges(String id) async{
    List<Charge> chargeList = await chargeCollection
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (charge) => Charge.fromSnapshot(charge.data())).toList();
        }
    );
    return chargeList;
  }

  @override
  Future<List<Destination>> getDestinations(String id) async{
    List<Destination> destinationList = await destinationCollection
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (destination) => Destination.fromSnapshot(destination.data())).toList();
        }
    );
    return destinationList;
  }

  @override
  Future<List<Document>> getDocuments(String id) async{
    List<Document> documentList = await documentCollection
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (document) => Document.fromSnapshot(document.data())).toList();
        }
    );
    return documentList;
  }

  @override
  Future<Payroll> getPayroll(String id, int month, int year) async{
    List<Payroll> payrollList = await payrollCollection.limit(1)
        .where('id', isEqualTo: id)
        .where('month', isEqualTo: month)
        .where('year', isEqualTo: year)
        .get().then(
            (snapshot){
              return snapshot.docs.map(
                  (payroll) => Payroll.fromSnapshot(payroll.data())).toList();
        }
    );
    return payrollList.first;
  }

  @override
  Future<Scale> getScale(String id) async{
    List<Scale> scaleList = await scaleCollection.limit(1)
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (scale) => Scale.fromSnapshot(scale.data())).toList();
        }
    );
    return scaleList.first;
  }

  @override
  Future<List<CourseFinished>> getCoursesFinished(String id) async {
    List<CourseFinished> courseFinishedList = await courseFinishedCollection
        .where('id', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (courseFinished) => CourseFinished.fromSnapshot(courseFinished.data())).toList();
        }
    );
    return courseFinishedList;
  }

  // Get courses information
  @override
  Future<List<Course>> getCourses(String cepCode) async{
    List<Course> courseList = await courseCollection
        .where('cepCode', isEqualTo: cepCode)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (course) => Course.fromSnapshot(course.data())).toList();
        }
    );
    return courseList;

  }

  // Get current job for current user
  @override
  Future<CurrentJob> getCurrentJob(String id) async {
    List<CurrentJob> currentJobList = await jobCollection.limit(1)
        .where('owner', isEqualTo: id)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (job) => CurrentJob.fromSnapshot(job.data())).toList();
        }
    );
    return currentJobList.first;
  }

  // Get procedures list
  @override
  Future<List<Procedure>> getProcedures() async {
    List<Procedure> procedureList = await procedureCollection
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (procedure) => Procedure.fromSnapshot(procedure.data())).toList();
        }
    );
    return procedureList;
  }

  // Get procedure results
  @override
  Future<List<ProcedureResult>> getProcedureResult(String procedureId) async {
    CollectionReference procedureResultsCollection = await procedureCollection.limit(1)
        .where('id', isEqualTo: procedureId)
        .get().then(
            (snapshot) => snapshot.docs.first.reference.collection('ProcedureResults')
    );
    List<ProcedureResult> procedureResults = await procedureResultsCollection.get().then(
            (snapshot){
              return snapshot.docs.map(
                      (doc) => ProcedureResult.fromSnapshot(doc.data() as Map<String, dynamic>)).toList();
            }
    );
    return procedureResults;
  }

  // User request to be part of this procedure and send the available job list ordered by his/her preference
  @override
  Future<void> registerProcedure(String procedureId, String userId, String jobIdList) async {
    await procedureCollection.where('id', isEqualTo: procedureId)
        .get().then((docSnapshot){
          docSnapshot.docs.first.reference.collection('Petitions').doc(userId).set({
            'timestamp' : Timestamp.now(),
            'petition' : jobIdList
          });
    });
  }

  @override
  Future<List<CurrentJob>> getAvailableJobs() async{
    List<CurrentJob> availableJobList = await jobCollection
        .where('available', isEqualTo: true)
        .get().then(
            (snapshot){
          return snapshot.docs.map(
                  (job) => CurrentJob.fromSnapshot(job.data())).toList();
        }
    );
    return availableJobList;
  }

  @override
  Future<bool> checkUserCredentials(String id, String password) async{
    bool result = await userCollection
        .where('id', isEqualTo: id)
        .where('password', isEqualTo: password)
        .limit(1)
        .get().then(
          (snapshot) => snapshot.docs.first.exists
        );
    return result;
  }

}