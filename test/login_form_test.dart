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


import 'package:gestint/views/login_view.dart';

void main() {

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('User id and password are empty', (WidgetTester tester) async {
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

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    //both fields empty
    expect(formKey.currentState!.validate(), isFalse);

  });

  testWidgets('User id is filled and password is empty', (WidgetTester tester) async {
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

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    Finder id = find.byKey(new Key('userId'));

    //only password field empty
    await tester.enterText(id, "X12345678");
    await tester.pump();

    expect(formKey.currentState!.validate(), isFalse);

  });

  testWidgets('User id is empty and password is filled', (WidgetTester tester) async {
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

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    Finder pwd = find.byKey(new Key('password'));

    //only userId field empty
    await tester.enterText(pwd, "1234");
    await tester.pump();

    expect(formKey.currentState!.validate(), isFalse);

  });

  testWidgets('Email and password fields filled', (WidgetTester tester) async {
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

    Finder formWidgetFinder = find.byType(Form);
    Form formWidget = tester.widget(formWidgetFinder) as Form;
    GlobalKey<FormState> formKey = formWidget.key as GlobalKey<FormState>;

    //both fields empty
    expect(formKey.currentState!.validate(), isFalse);

    Finder id = find.byKey(new Key('userId'));
    Finder pwd = find.byKey(new Key('password'));

    //both fields filled
    await tester.enterText(id, "X12345678");
    await tester.enterText(pwd, "1234");
    await tester.pump();

    expect(formKey.currentState!.validate(), isTrue);

  });

}
