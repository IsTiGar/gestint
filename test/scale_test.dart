// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:gestint/models/scale_model.dart';

void main() {

  testWidgets('Check scale model calculateTotalScale() method', (WidgetTester tester) async {

    final scale = Scale(
        10, // publicExp
        10, // privateExp
        10, // universityExp
        10, // academicQual
        10, // phd
        10, // other
        10, // special
        10, // catalan
        10, // courses
        10); // coursesHours

    var totalScale = scale.calculateTotalScale();

    expect(totalScale, '90.000'); // using toStringAsFixed(3)

  });

}
