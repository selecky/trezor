
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trezor/blocs/cred_cubit.dart';
import 'package:trezor/screens/pin_screen.dart';
import 'package:trezor/strings/strings.dart';

class MockCredCubit extends MockCubit<CredState> implements CredCubit {}

void main() {
  late MockCredCubit mockCredCubit;

  setUp(() {
    mockCredCubit = MockCredCubit();
  });

  testWidgets('test PinScreen UI', (WidgetTester tester) async {

    await tester.pumpWidget(
        BlocProvider<CredCubit>.value(
            value: mockCredCubit,
            child: const MaterialApp(
                home: Scaffold(
                    body: PinScreen()))));

    expect(find.text(Strings.pin), findsOneWidget);
    expect(find.text(Strings.setPin), findsOneWidget);
    expect(find.text(Strings.savePin), findsOneWidget);

    expect(find.byKey(const Key('Num1')), findsOneWidget);
    expect(find.byKey(const Key('Num2')), findsOneWidget);
    expect(find.byKey(const Key('Num3')), findsOneWidget);
    expect(find.byKey(const Key('Num4')), findsOneWidget);

    expect(find.byKey(const Key('SavePinButton')), findsOneWidget);

    // inactive grey savePin button
    expect(((tester.firstWidget(find.byType(Container)) as Container).decoration
    as BoxDecoration).color, Colors.black12);

    await tester.enterText(find.byKey(const Key('Num1'),), '1');
    await tester.enterText(find.byKey(const Key('Num2'),), '1');
    await tester.enterText(find.byKey(const Key('Num3'),), '1');
    await tester.enterText(find.byKey(const Key('Num4'),), '1');

    await tester.pumpAndSettle();

    // active blue savePin button
    expect(((tester.firstWidget(find.byType(Container)) as Container).decoration
    as BoxDecoration).color, Colors.blue);

  });
}
