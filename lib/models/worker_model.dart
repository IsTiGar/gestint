class Worker {

  final String id;
  final String firstName;
  final String lastName1;
  final String lastName2;
  final String emailAddress;
  final String pictureURL;

  Worker(
      this.id,
      this.lastName1,
      this.lastName2,
      this.emailAddress,
      this.pictureURL,
      this.firstName);

  Worker.fromSnapshot(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName1 = json['lastName1'],
        lastName2 = json['lastName2'],
        emailAddress = json['emailAddress'],
        pictureURL = json['pictureURL'];

}
