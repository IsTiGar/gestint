// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestint/helpers/setupFirebaseAuthMocks.dart';
import 'package:gestint/theme/custom_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:gestint/views/login_view.dart';

void main() {

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Check user credentials on Firestore', (WidgetTester tester) async {

    // Populate the fake database.
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('User').add({
      'id': 'X12345678',
      'password': '1234',
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'Gestint',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ca', ''), // Catalan
        Locale('es', ''), // Spanish
      ],
      theme: CustomTheme.lightTheme,
      home: LoginView(),
    ));

    final snapshot = await firestore.collection('User')
        .where('id', isEqualTo: 'X12345678')
        .where('password', isEqualTo: '1234')
        .limit(1).get();

    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.get('id'), 'X12345678');
    expect(snapshot.docs.first.exists, true);

    print(firestore.dump());

  });

  testWidgets('Check wrong user credentials on Firestore', (WidgetTester tester) async {

    // Populate the fake database.
    final firestore = FakeFirebaseFirestore();
    await firestore.collection('User').add({
      'id': 'X12345678',
      'password': '1234',
    });

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      title: 'Gestint',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ca', ''), // Catalan
        Locale('es', ''), // Spanish
      ],
      theme: CustomTheme.lightTheme,
      home: LoginView(),
    ));

    final snapshot = await firestore.collection('User')
        .where('id', isEqualTo: 'X12345678')
        .where('password', isEqualTo: '1243')
        .limit(1).get();

    expect(snapshot.docs.isEmpty, true);

  });
}
