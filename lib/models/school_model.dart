class School {

  final String name;
  final String address;
  final double locationLat;
  final double locationLong;
  final String body;
  final String phoneNumber;

  School(this.name, this.address, this.locationLat, this.locationLong, this.body, this.phoneNumber);

  School.fromSnapshot(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        locationLat= json['locationLat'],
        locationLong = json['locationLong'],
        body = json['body'],
        phoneNumber = json['phoneNumber'];
}
