class PersonalData {

  final String firstName;
  final String lastName1;
  final String lastName2;
  final String nif;
  final String gender;
  final String nationality;
  final String dateOfBirth;
  final String birthProvince;
  final String birthCity;
  final String birthCountry;
  final String address;
  final String city;
  final String province;
  final String phoneNumber;
  final String emailAddress;

  PersonalData(
      this.firstName,
      this.lastName1,
      this.lastName2,
      this.nif,
      this.gender,
      this.nationality,
      this.dateOfBirth,
      this.birthProvince,
      this.birthCity,
      this.birthCountry,
      this.address,
      this.city,
      this.province,
      this.phoneNumber,
      this.emailAddress);

  PersonalData.fromSnapshot(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName1 = json['lastName1'],
        lastName2 = json['lastName2'],
        nif = json['nif'],
        gender = json['gender'],
        nationality = json['nationality'],
        dateOfBirth = json['dateOfBirth'],
        birthProvince = json['birthProvince'],
        birthCity= json['birthCity'],
        birthCountry = json['birthCountry'],
        address = json['address'],
        city = json['city'],
        province = json['province'],
        phoneNumber = json['phoneNumber'],
        emailAddress = json['emailAddress'];

}
