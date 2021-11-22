import 'package:gestint/models/payroll_model.dart';

abstract class PayrollViewContract{
  void onLoadPayrollComplete(Payroll payroll);
  void onLoadPayrollError();
}