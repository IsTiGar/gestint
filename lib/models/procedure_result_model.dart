
class ProcedureResult {

  final String function;
  final String type;
  final bool partTime;
  final String school;
  final String startDate;
  final String endDate;
  final String newOwner;
  final double score;

  ProcedureResult(
      this.function,
      this.type,
      this.partTime,
      this.school,
      this.startDate,
      this.endDate,
      this.newOwner,
      this.score);

  ProcedureResult.fromSnapshot(Map<String, dynamic> json)
      : function = json['function'],
        type = json['type'],
        partTime = json['partTime'],
        school = json['school'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        newOwner = json['newOwner'],
        score = json['score'] == null ? 0.0 : json['score'].toDouble();

}
