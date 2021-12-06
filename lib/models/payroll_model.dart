
class Payroll {

  final int month;
  final int year;
  final double base;
  final double destinationComplement;
  final double residenceComplement;
  final double generalComplement;
  final double communityComplement;
  final double irpf;
  final double contribution;

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
        irpf = json['irpf'] == null ? 0.0 : json['irpf'].toDouble(), // forcefully convert to double
        contribution = json['contribution'];

  double calculateAccrual() {
    double accrual = this.base + this.destinationComplement + this.residenceComplement + this.generalComplement + this.communityComplement;
    return accrual;
  }

  double calculateIrpf() {
    return calculateAccrual() * this.irpf/100;
  }

  double calculateTaxes() {
    double taxes = calculateIrpf() + this.contribution;
    return taxes;
  }

  double calculateSalary() {
    double salary = calculateAccrual() - calculateTaxes();
    return salary;
  }

}
