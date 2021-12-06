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
import 'package:gestint/models/scale_model.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/models/worker_full_model.dart';
import 'package:gestint/models/worker_model.dart';

class DataRepository implements WorkerContract,
    SchoolsContract, PersonalDataContract, CertificationsContract,
    ChargesContract, CoursesContract, CoursesFinishedContract, 
    DestinationsContract, DocumentsContract, PayrollContract,
    ScaleContract, AvailableWorkersContract, CurrentJobContract,
    ProceduresContract, SingleProcedureContract, UserContract{

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

  @override
  Future<List<WorkerFull>> getAvailableWorkers(String body, String function) async{
    var availableWorkers = <WorkerFull>[];
    await workerFullCollection
        .where('body', isEqualTo: body)
        .where('function', isEqualTo: function)
        .where('available', isEqualTo: true)
        .orderBy('score', descending: true)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (availableWorker) {
                  availableWorkers.add(WorkerFull.fromSnapshot(availableWorker.data()));
            },
          ),
    );
    print('Resultados: ' + availableWorkers.length.toString());
    return availableWorkers;
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

  @override
  Future<List<Certification>> getCertifications(String id) async {
    var certifications = <Certification>[];
    await certificationCollection
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (certification) {
                  certifications.add(Certification.fromSnapshot(certification.data()));
            },
          ),
    );
    return certifications;
  }

  @override
  Future<List<Charge>> getCharges(String id) async{
    var charges = <Charge>[];
    await chargeCollection
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (charge) {
              charges.add(Charge.fromSnapshot(charge.data()));
            },
          ),
    );
    return charges;
  }

  @override
  Future<List<Destination>> getDestinations(String id) async{
    var destinations = <Destination>[];
    await destinationCollection
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (destination) {
              destinations.add(Destination.fromSnapshot(destination.data()));
            },
          ),
    );
    return destinations;
  }

  @override
  Future<List<Document>> getDocuments(String id) async{
    var documents = <Document>[];
    await documentCollection
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (document) {
              documents.add(Document.fromSnapshot(document.data()));
            },
          ),
    );
    return documents;
  }

  @override
  Future<Payroll> getPayroll(String id, int month, int year) async{
    var payrolls = <Payroll>[];
    await payrollCollection
        .where('id', isEqualTo: id)
        .where('month', isEqualTo: month)
        .where('year', isEqualTo: year)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (payroll) {
              payrolls.add(Payroll.fromSnapshot(payroll.data()));
            },
          ),
    );
    print('Longitud del vector: ' + payrolls.length.toString());
    return payrolls.first;
  }

  @override
  Future<Scale> getScale(String id) async{
    var scales = <Scale>[];
    await scaleCollection.limit(1)
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (scale) {
              scales.add(Scale.fromSnapshot(scale.data()));
            },
          ),
    );
    return scales.first;
  }

  @override
  Future<List<CourseFinished>> getCoursesFinished(String id) async {
    var coursesFinished = <CourseFinished>[];
    await courseFinishedCollection
        .where('id', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (courseFinished) {
              coursesFinished.add(CourseFinished.fromSnapshot(courseFinished.data()));
            },
          ),
    );
    return coursesFinished;
  }

  @override
  Future<List<Course>> getCourses() async{
    var courses = <Course>[];
    await courseCollection.get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (course) {
              courses.add(Course.fromSnapshot(course.data()));
            },
          ),
    );
    return courses;
  }

  @override
  Future<CurrentJob> getCurrentJob(String id) async {
    var currentJobs = <CurrentJob>[];
    await jobCollection.limit(1)
        .where('owner', isEqualTo: id)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (job) {
              currentJobs.add(CurrentJob.fromSnapshot(job.data()));
            },
          ),
    );
    return currentJobs.first;
  }

  @override
  Future<List<Procedure>> getProcedures() async {
    var procedures = <Procedure>[];
    await procedureCollection.get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (procedure) {
              procedures.add(Procedure.fromSnapshot(procedure.data()));
            },
          ),
    );
    return procedures;
  }

  @override
  Future<void> registerProcedure(String procedureId, String userId, String jobIdList) async {

    var result = false;

    await procedureCollection.where('id', isEqualTo: procedureId)
        .get().then((docSnapshot){
          docSnapshot.docs.first.reference.collection('Petitions').doc(userId).set({
            'timestamp' : Timestamp.now(),
            'petition' : jobIdList
          });
    });

    //return result;

  }

  @override
  Future<List<CurrentJob>> getAvailableJobs() async{
    var availableJobs = <CurrentJob>[];
    await jobCollection
        .where('available', isEqualTo: true)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (job) {
                  availableJobs.add(CurrentJob.fromSnapshot(job.data()));
            },
          ),
    );
    return availableJobs;
  }

  @override
  Future<bool> checkUserCredentials(String id, String password) async{
    bool result = false;
    await userCollection
        .where('id', isEqualTo: id)
        .where('password', isEqualTo: password)
        .limit(1)
        .get().then(
          (snapshot) =>
          snapshot.docs.forEach(
                (user) {
              if(user.exists) result = true;
            },
          ),
    );
    return result;
  }

}