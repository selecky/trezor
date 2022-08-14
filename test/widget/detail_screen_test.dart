
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/repos/cred_repo.dart';
import 'package:trezor/screens/detail_screen.dart';
import 'package:trezor/strings/strings.dart';

class MockCredRepo extends Mock implements CredRepo {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockCredRepo mockCredRepo;
  late Credential testCred;

  setUpAll((){
    mockCredRepo = MockCredRepo();
    final locator = GetIt.I;
    locator.registerSingleton<CredRepo>(mockCredRepo);
    testCred = const Credential(id: 'id', title: 'title', username: 'username', password: 'password');
  });

  testWidgets('test PinScreen UI', (WidgetTester tester) async {

    when(() => mockCredRepo.getPin()).thenAnswer((_) async => 'testPIN');
    when(() => mockCredRepo.getCredPassword(any())).thenAnswer((_) async => 'testPassword');

    await tester.pumpWidget(
        MaterialApp(
            home: Scaffold(
                body: DetailScreen(credential: testCred,))));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text(Strings.detail), findsOneWidget);

    expect(find.byIcon(Icons.topic), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.byIcon(Icons.key), findsOneWidget);
    expect(find.byIcon(Icons.copy), findsNWidgets(3));
    expect(find.byIcon(Icons.visibility), findsOneWidget);

    expect(find.byIcon(Icons.delete_forever), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);

  });
}
