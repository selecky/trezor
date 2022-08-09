
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/screens/add_edit_cred_screen.dart';
import 'package:trezor/strings/strings.dart';


void main() {
  late Credential testCred;

  setUp(() {
    testCred = const Credential(id: 'id', title: 'title', username: 'username', password: 'password');
  });

  testWidgets('test AddEditCredScreen when adding', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
                body: AddEditCredScreen())));

    expect(find.text(Strings.addCredential), findsNWidgets(2));

    expect(find.byIcon(Icons.topic), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.byIcon(Icons.key), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    // showing SnackBar
    expect(find.byType(SnackBar), findsOneWidget);

  });

  testWidgets('test AddEditCredScreen when editing', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: Scaffold(
                body: AddEditCredScreen(credential: testCred,))));

    expect(find.text(Strings.editCredential), findsNWidgets(2));

    expect(find.byIcon(Icons.topic), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.byIcon(Icons.key), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

}
