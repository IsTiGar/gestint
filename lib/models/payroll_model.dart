import 'dart:ffi';

class Payroll {

  final int month;
  final int year;
  final Float base;
  final Float destinationComplement;
  final Float residenceComplement;
  final Float generalComplement;
  final Float communityComplement;
  final Float irpf;
  final Float contribution;

  Payroll(
      this.month,
      this.year,
      this.base,
      this.destinationComplement,
      this.residenceComplement,
      this.generalComplement,
      this.communityComplement,
      this.irpf,
      this.contribution);

  Payroll.fromSnapshot(Map<String, dynamic> json)
      : month = json['month'],
        year = json['year'],
        base = json['base'],
        destinationComplement = json['destinationComplement'],
        residenceComplement = json['residenceComplement'],
        generalComplement = json['generalComplement'],
        communityComplement = json['communityComplement'],
        irpf = json['irpf'],
        contribution = json['contribution'];

}
