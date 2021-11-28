class Procedure {

  final String id;
  final String description;
  final String startDate;
  final String endDate;
  final String resultsDate;
  final bool isActive;

  Procedure(
      this.id,
      this.description,
      this.startDate,
      this.endDate,
      this.resultsDate,
      this.isActive);

  Procedure.fromSnapshot(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        resultsDate = json['resultsDate'],
        isActive = json['isActive'];

}
