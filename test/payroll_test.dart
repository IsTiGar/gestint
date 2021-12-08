// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gestint/models/payroll_model.dart';

void main() {

  testWidgets('Check payroll methods', (WidgetTester tester) async {

    final payroll = Payroll(
        11, // month
        2021, // year
        20, // base
        20, // destinationComplement
        20, // residenceComplement
        20, // generalComplement
        20, // communityComplement
        20, // irpf
        10); // contribution

    var accrual = payroll.calculateAccrual();
    var irpf = payroll.calculateIrpf();
    var taxes = payroll.calculateTaxes();
    var salary = payroll.calculateSalary();

    expect(accrual, 100);
    expect(irpf, 20); // 20% of accrual
    expect(taxes, 30); // irpf + contribution
    expect(salary, 70); // accrual - taxes

  });


}
