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


/*FutureBuilder<QuerySnapshot>(
future: FirebaseFirestore.instance.collection("Worker")
.where("id", isEqualTo: "X46959966")
.get(),
builder: (BuildContext context, snapshot) {
if (snapshot.hasError) {
return Text("Something went wrong");
}

if (snapshot.connectionState == ConnectionState.done) {
var list = snapshot.data!.docs.toList();
return Text("Name: ${list.first["lastName1"]}");
}

return CircularProgressIndicator();
}
)*/