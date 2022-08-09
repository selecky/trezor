import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/models/credential.dart';
import 'package:trezor/myWidgets/my_credential_card.dart';
import 'package:trezor/screens/add_edit_cred_screen.dart';
import 'package:trezor/screens/master_screen.dart';
import 'package:trezor/strings/strings.dart';

class MockCredCubit extends MockCubit<CredState> implements CredCubit {}

void main() {
  late MockCredCubit mockCredCubit;
  late Credential testCred;
  late List<Credential> credList;

  setUp(() {
    mockCredCubit = MockCredCubit();
    testCred = const Credential(id: 'id', title: 'title', username: 'username', password: 'password');
    credList = [];
  });

  testWidgets('test empty MasterScreen', (WidgetTester tester) async {

    when(() => mockCredCubit.state).thenReturn(const CredStateSuccess(credList: []));

    await tester.pumpWidget(
        BlocProvider<CredCubit>.value(
        value: mockCredCubit,
        child: const MaterialApp(
            home: Scaffold(
                body: MasterScreen()))));

    expect(find.text(Strings.appTitle), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(MyCredentialCard), findsNothing);
    expect(find.text(Strings.emptyCredListText), findsOneWidget);
    expect(find.text(Strings.addCredentialsInfo), findsOneWidget);
  });

  testWidgets('test MasterScreen with credential', (WidgetTester tester) async {

    credList.add(testCred);

    when(() => mockCredCubit.state).thenReturn(CredStateSuccess(credList: credList));

    await tester.pumpWidget(
        BlocProvider<CredCubit>.value(
            value: mockCredCubit,
            child: const MaterialApp(
                home: Scaffold(
                    body: MasterScreen()))));

    expect(find.text(Strings.appTitle), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(MyCredentialCard), findsOneWidget);
    expect(find.text(Strings.emptyCredListText), findsNothing);
    expect(find.text(Strings.addCredentialsInfo), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(AddEditCredScreen), findsOneWidget);
  });
}
