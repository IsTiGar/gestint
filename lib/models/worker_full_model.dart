//TODO extends from Worker

class WorkerFull {

  final String body;
  final String firstName;
  final String lastName1;
  final String lastName2;
  final String function;
  final double score;
  final bool trained;

  WorkerFull(
      this.body,
      this.firstName,
      this.lastName1,
      this.lastName2,
      this.function,
      this.score,
      this.trained);

  WorkerFull.fromSnapshot(Map<String, dynamic> json)
      : body = json['body'],
        firstName = json['firstName'],
        lastName1 = json['lastName1'],
        lastName2 = json['lastName2'],
        function = json['function'],
        score = json['score'] == null ? 0.0 : json['score'].toDouble(),
        trained = json['trained'];

}
