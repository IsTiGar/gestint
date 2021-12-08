// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gestint/models/charge_model.dart';

void main() {

  testWidgets('Check charge calculateTime() method (days)', (WidgetTester tester) async {

    final charge1 = Charge(
        'fake body', // body
        'fake type', // type
        'fake school', // school
        '20/11/2021', // startDate
        '29/11/2021'); // endDate

    var diff1 = charge1.calculateTime(); // returns [years, months, days]

    expect(diff1[0], 0); // years
    expect(diff1[1], 0); // months
    expect(diff1[2], 10); // days

  });

  testWidgets('Check charge calculateTime() method (days and months)', (WidgetTester tester) async {

    final charge2 = Charge(
        'fake body', // body
        'fake type', // type
        'fake school', // school
        '20/10/2021', // startDate
        '29/11/2021'); // endDate

    var diff2 = charge2.calculateTime(); // returns [years, months, days]

    expect(diff2[0], 0); // years
    expect(diff2[1], 1); // months
    expect(diff2[2], 10); // days

  });

  testWidgets('Check charge calculateTime() method (days, months and years)', (WidgetTester tester) async {

    final charge3 = Charge(
        'fake body', // body
        'fake type', // type
        'fake school', // school
        '20/10/2020', // startDate
        '29/11/2021'); // endDate

    var diff3 = charge3.calculateTime(); // returns [years, months, days]

    expect(diff3[0], 1); // years
    expect(diff3[1], 1); // months
    expect(diff3[2], 10); // days

  });


}
