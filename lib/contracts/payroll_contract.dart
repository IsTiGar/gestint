
import 'package:gestint/models/payroll_model.dart';

abstract class PayrollContract {
  Future<Payroll> getPayroll(String id, int month, int year);
}